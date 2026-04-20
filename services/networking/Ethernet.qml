pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

/**
 * Network Status for ethernet until Quickshell.Networking is completelly implemented
 */
Singleton {
    id: root

    property bool available: false
    property string connectivity: "none" // none, portal, limited, full

    // Trigger update on init
    Component.onCompleted: updateTimer.restart()

    // Debounce timer to prevent nmcli spam
    Timer {
        id: updateTimer
        interval: 200
        repeat: false
        onTriggered: updateProcess.startCheck()
    }

    // Monitor for changes
    Process {
        id: monitor
        command: ["nmcli", "monitor"]
        running: true
        stdout: SplitParser {
            // Every time nmcli monitor outputs a line, we queue an update
            onRead: updateTimer.restart()
        }
    }

    Process {
        id: updateProcess
        running: false

        /**
         * COMMAND BREAKDOWN:
         * * 1. nmcli -t -f TYPE,STATE d:
             * -t (--terse):  Removes headers/pretty-printing. Fields are separated by colons (:).
             * -f (--fields): Specifies which columns to output. We only want TYPE and STATE.
             * d (device):    The object we are querying (network interfaces).
         * * 2. nmcli -t g connectivity:
             * -t:            Terse mode again.
             * g (general):   The object for global NetworkManager status.
         */
        command: ["sh", "-c", "nmcli -t -f TYPE,STATE d && echo '---' && nmcli -t g"]

        property string buffer: ""

        function startCheck() {
            if (running)
                terminate();
            buffer = "";
            running = true;
        }

        stdout: SplitParser {
            onRead: data => updateProcess.buffer += data + "\n"
        }

        onExited: {
            const output = buffer.trim();
            if (!output)
                return;

            const sections = output.split('---');
            if (sections.length < 2)
                return;

            const deviceLines = sections[0].trim().split('\n');

            const generalStatusLine = sections[1].trim();
            const connectivityStatus = generalStatusLine.split(':')[1];

            let hasEth = false;
            let ethConnected = false;

            deviceLines.forEach(line => {
                const [type, state] = line.split(':');
                if (!type || !state)
                    return;

                // Ignore virtual interfaces and loopbacks
                if (type === "loopback" || type === "bridge")
                    return;

                if (type.includes("ethernet")) {
                    hasEth = true;
                    const isConnected = state.includes("connected") && !state.includes("disconnected");
                    ethConnected = isConnected;
                }
            });

            root.available = hasEth;
            root.connectivity = connectivityStatus;

            console.debug(`Ethernet update: Eth:${hasEth} ConnStatus:${connectivityStatus}`);
        }
    }
}
