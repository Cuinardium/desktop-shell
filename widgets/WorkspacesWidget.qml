pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

import qs.components

RowLayout {
    id: workspaces
    required property HyprlandMonitor monitor

    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        Workspace {
            // Only show workspaces belonging to the current monitor
            currentMonitorName: workspaces.monitor.name
        }
    }
}
