import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

import qs.style

RowLayout {
    required property HyprlandMonitor monitor
    property string appId: monitor.activeWorkspace.toplevels.values.find(t => t.activated).wayland.appId
    property var mappedEntry: IconMap.getMatch(appId)

    spacing: 8

    Text {
        text: mappedEntry.icon
        color: Theme.primary
        font.pixelSize: 26
    }

    Text {
        text: mappedEntry.title
        color: Theme.primary
        font.pixelSize: 14
        font.bold: true
    }
}
