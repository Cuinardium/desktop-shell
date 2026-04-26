pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

/**
 * Polled resource usage service with RAM, Swap, CPU usage, and Temperature.
 */
Singleton {
    id: root

    // --- Configuration Paths ---
    property string thermalPath: "/sys/class/hwmon/hwmon2/temp1_input"
    property string maxFreqPath: "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"

    // --- Memory & Swap ---
    property real memoryTotal: 1
    property real memoryFree: 0
    property real memoryUsed: memoryTotal - memoryFree
    property real memoryUsedPercentage: memoryTotal > 0 ? (memoryUsed / memoryTotal) : 0

    property real swapTotal: 1
    property real swapFree: 0
    property real swapUsed: swapTotal - swapFree
    property real swapUsedPercentage: swapTotal > 0 ? (swapUsed / swapTotal) : 0

    // --- CPU ---
    property real cpuUsage: 0
    property real cpuTemp: 0
    property var previousCpuStats: null

    // --- Display Strings ---
    property string maxAvailableMemoryString: kbToGbString(memoryTotal)
    property string maxAvailableSwapString: kbToGbString(swapTotal)
    property string maxAvailableCpuString: "--"

    // --- History ---
    readonly property int historyLength: 60
    // Using 'var' instead of 'list<real>' for more efficient manual array manipulation
    property var cpuUsageHistory: []
    property var cpuTempHistory: []
    property var memoryUsageHistory: []
    property var swapUsageHistory: []

    function kbToGbString(kb) {
        return (kb / (1024 * 1024)).toFixed(1) + " GB";
    }

    // History update
    function pushToHistory(historyArray, newValue) {
        historyArray.push(newValue);
        if (historyArray.length > historyLength) {
            historyArray.shift();
        }
        // Slice creates a fast shallow copy to notify QML property bindings of the change
        return historyArray.slice();
    }

    function poll() {
        fileMeminfo.reload();
        fileStat.reload();
        fileTemp.reload();

        // Parse Memory & Swap
        const textMeminfo = fileMeminfo.text();
        memoryTotal = Number(textMeminfo.match(/MemTotal:\s+(\d+)/)?.[1] || 1);
        memoryFree = Number(textMeminfo.match(/MemAvailable:\s+(\d+)/)?.[1] || 0);
        swapTotal = Number(textMeminfo.match(/SwapTotal:\s+(\d+)/)?.[1] || 1);
        swapFree = Number(textMeminfo.match(/SwapFree:\s+(\d+)/)?.[1] || 0);

        // Parse CPU Usage
        const textStat = fileStat.text();
        const cpuLine = textStat.split('\n')[0].trim().split(/\s+/);

        if (cpuLine[0] === "cpu") {
            const user = Number(cpuLine[1] || 0);
            const nice = Number(cpuLine[2] || 0);
            const system = Number(cpuLine[3] || 0);
            const idle = Number(cpuLine[4] || 0);
            const iowait = Number(cpuLine[5] || 0);
            const irq = Number(cpuLine[6] || 0);
            const softirq = Number(cpuLine[7] || 0);
            const steal = Number(cpuLine[8] || 0);

            const idleAll = idle + iowait;
            const systemAll = system + irq + softirq;
            const nonIdleAll = user + nice + systemAll + steal;
            const total = idleAll + nonIdleAll;

            if (previousCpuStats) {
                const totalDiff = total - previousCpuStats.total;
                const idleDiff = idleAll - previousCpuStats.idleAll;
                cpuUsage = totalDiff > 0 ? (totalDiff - idleDiff) / totalDiff : 0;
            }

            previousCpuStats = { total: total, idleAll: idleAll };
        }

        // Parse CPU Temperature
        const tempRaw = Number(fileTemp.text() || 0);
        cpuTemp = tempRaw > 0 ? (tempRaw / 1000) : 0;

        // Update Histories
        memoryUsageHistory = pushToHistory(memoryUsageHistory, memoryUsedPercentage);
        swapUsageHistory = pushToHistory(swapUsageHistory, swapUsedPercentage);
        cpuUsageHistory = pushToHistory(cpuUsageHistory, cpuUsage);
        cpuTempHistory = pushToHistory(cpuTempHistory, cpuTemp);
    }

    Timer {
        interval: 1
        running: true
        repeat: true
        onTriggered: {
            root.poll();
            interval = interval === 1 ? 500 : 3000;
        }
    }

    FileView {
        id: fileMeminfo
        path: "/proc/meminfo"
    }
    FileView {
        id: fileStat
        path: "/proc/stat"
    }
    FileView {
        id: fileTemp
        path: root.thermalPath
    }

    FileView {
        id: fileMaxFreq
        path: root.maxFreqPath
        onTextChanged: {
            const khz = Number(text());
            if (khz > 0) {
                root.maxAvailableCpuString = (khz / 1000000).toFixed(1) + " GHz";
            }
        }
    }

    Component.onCompleted: {
        fileMaxFreq.reload();
    }
}
