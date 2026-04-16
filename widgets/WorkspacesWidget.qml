import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Services.Pipewire

import "../components"
import "../style"
import "../style/motions"
import "../util"

RowLayout {
    id: workspaces
    required property HyprlandMonitor monitor

    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        ClickablePill {
            id: workspacePill
            onClicked: modelData.activate()

            readonly property bool isFocused: modelData.focused
            readonly property var windows: modelData.toplevels.values
            readonly property bool isEmpty: windows.length === 0

            readonly property string icons: windows.slice(0, 3).map(t => IconMap.getMatch(t.wayland.appId).icon).join(" ")

            visible: modelData.monitor.name === workspaces.monitor.name

            readonly property real targetWidth: isEmpty ? implicitHeight : iconText.width + 24
            property real animatedWidth: targetWidth
            NumberMotion on animatedWidth {}

            implicitWidth: animatedWidth
            implicitHeight: 30
            clip: true

            backgroundColor: {
                if (isFocused)
                    return Theme.surface_container_highest;
                return workspacePill.containsMouse ? Theme.surface_container_high : Theme.surface_container_low;
            }
            ColorMotion on backgroundColor {}

            borderColor: isFocused ? Theme.primary : Theme.outline_variant
            ColorMotion on borderColor {}
            borderWidth: 2

            // Window Icons
            Text {
                id: iconText
                visible: !workspacePill.isEmpty
                Layout.alignment: Qt.AlignCenter
                color: Theme.primary
                font {
                    bold: true
                    pixelSize: 22
                }

                text: workspacePill.icons
                opacity: workspacePill.isEmpty ? 0 : 1
                scale: workspacePill.isEmpty ? 0.5 : (workspacePill.isFocused ? 1.1 : 1.0)

                NumberMotion on scale {}
                NumberMotion on opacity {}
            }

            // Central Dot (Empty indicator)
            Rectangle {
                id: emptyIndicator
                Layout.alignment: Qt.AlignCenter
                visible: workspacePill.isEmpty
                width: 10
                height: 10
                radius: 5

                color: workspacePill.isFocused ? Theme.primary : Theme.outline_variant

                opacity: workspacePill.isEmpty ? 1 : 0
                scale: workspacePill.isEmpty ? (workspacePill.isFocused ? 1.2 : 1.0) : 0.5

                NumberMotion on scale {}
                NumberMotion on opacity {}
                ColorMotion on color {}
            }
        }
    }
}
