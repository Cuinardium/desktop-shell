pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property string currentSearchTerm: ""
    property var filteredApps: []

    // 1. Declarative File Management
    FileView {
        id: cacheFile
        path: Quickshell.env("HOME") + "/.cache/launcher-frecency.json"

        // Reload if the file is changed externally (e.g., you edit it in vim)
        watchChanges: true
        onFileChanged: reload()

        // Automatically save to disk when the adapter's properties change
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: frecencyData
            // This maps directly to the "history" key in your JSON file.
            // If the file is empty or missing, it defaults to an empty object.
            property var history: ({})
        }

        onLoaded: {
            root.updateFilter();
        }

        onLoadFailed: (error) => {
            root.ensureFileExists();
        }
    }

    Connections {
        target: DesktopEntries
        function onApplicationsChanged() {
            root.updateFilter();
        }
    }

    // --- Public API for the UI ---

    function search(term) {
        root.currentSearchTerm = term;
        root.updateFilter();
    }

    function launch(index) {
        if (index >= 0 && index < root.filteredApps.length) {
            let app = root.filteredApps[index];
            trackLaunch(app);
            app.execute();
            return true;
        }
        return false;
    }

    // --- Internal Logic ---

    function ensureFileExists() {
        try {
            let content = cacheFile.text();

            if (!content || content.trim() === "") {
                // If the file is empty, create it with an empty object
                cacheFile.setText('{"history": {}}');
            }
        } catch (e) {
            // If the file doesn't exist, create it with an empty object
            cacheFile.setText('{"history": {}}');
        }
    }

    function trackLaunch(entry) {
        let appId = entry.id;
        let now = Date.now();

        // We create a copy of the history object so that reassigning it
        // properly triggers the QML property change signal and saves the file.
        let updatedHistory = Object.assign({}, frecencyData.history);

        let appData = updatedHistory[appId] || {
            launches: 0,
            lastLaunch: now
        };
        appData.launches += 1;
        appData.lastLaunch = now;

        updatedHistory[appId] = appData;

        // This assignment triggers onAdapterUpdated -> writeAdapter()
        frecencyData.history = updatedHistory;
    }

    function getFrecencyScore(appId) {
        let data = frecencyData.history[appId];
        if (!data)
            return 0;

        let hoursSince = (Date.now() - data.lastLaunch) / (1000 * 60 * 60);
        return data.launches * Math.exp(-0.05 * hoursSince);
    }

    function updateFilter() {
        let allEntries = DesktopEntries.applications.values;
        let term = root.currentSearchTerm.toLowerCase();
        let results = [];

        for (let i = 0; i < allEntries.length; i++) {
            let entry = allEntries[i];
            let name = entry.name.toLowerCase();
            let generic = entry.genericName ? entry.genericName.toLowerCase() : "";

            let matchIndexName = name.indexOf(term);
            let matchIndexGeneric = generic.indexOf(term);

            if (term === "" || matchIndexName !== -1 || matchIndexGeneric !== -1) {
                let stringScore = 0;
                if (term !== "") {
                    if (matchIndexName === 0)
                        stringScore += 100;
                    else if (matchIndexName > 0)
                        stringScore += 20;

                    if (matchIndexGeneric === 0)
                        stringScore += 40;
                    else if (matchIndexGeneric > 0)
                        stringScore += 10;
                }

                let appId = entry.id;
                let frecencyScore = getFrecencyScore(appId);

                let finalScore = (term === "") ? frecencyScore : stringScore + (frecencyScore * 0.5);

                results.push({
                    entry: entry,
                    score: finalScore
                });
            }
        }

        results.sort(function (a, b) {
            return b.score - a.score;
        });

        root.filteredApps = results.map(function (item) {
            return item.entry;
        });
    }
}
