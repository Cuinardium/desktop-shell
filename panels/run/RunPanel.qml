pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import qs
import qs.style
import qs.style.motions
import qs.components

PanelWindow {
    id: panel

    screen: Quickshell.screens[0]

    anchors.bottom: true

    readonly property bool isVisibleOrAnimating: ShellState.runMenuOpen || slidingContainer.y < panel.totalHeight

    property int totalWidth: screen.width * 0.4
    property int totalHeight: screen.height * 0.5 + 10
    implicitWidth: totalWidth
    implicitHeight: ShellState.runMenuOpen || slideAnim.running ? totalHeight : 0

    exclusionMode: ExclusionMode.Ignore
    focusable: true
    color: "transparent"
    visible: isVisibleOrAnimating

    HyprlandFocusGrab {
        active: ShellState.runMenuOpen
        windows: [panel]
        onCleared: ShellState.runMenuOpen = false
    }

    Item {
        anchors.fill: parent
        clip: true
        focus: true

        Keys.onEscapePressed: ShellState.runMenuOpen = false

        Item {
            id: slidingContainer
            width: panel.totalWidth
            height: panel.totalHeight
            anchors.horizontalCenter: parent.horizontalCenter
            // Slides up from below: totalHeight = hidden, -2 = visible (slight overshoot)
            y: ShellState.runMenuOpen ? 10 : panel.totalHeight

            Behavior on y {
                Anim {
                    id: slideAnim
                    type: Anim.SlowSpatial
                }
            }

            BottomFlaredBackground {
                anchors.fill: parent
                flareRadius: 64
                cornerRadius: 32
            }

            RunPanelContent {
                anchors.fill: parent
                anchors.leftMargin: 64 + 32
                anchors.rightMargin: 64 + 32
                anchors.topMargin: 32
                anchors.bottomMargin: 20
            }
        }
    }
}
