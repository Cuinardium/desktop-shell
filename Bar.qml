import Quickshell // for PanelWindow
import Quickshell.Hyprland // for HyprlandMonitor
import QtQuick // for Text
import QtQuick.Layouts

import Quickshell.Networking
import "widgets"
import "style"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {

            required property var modelData
            property HyprlandMonitor hyprland_monitor: Hyprland.monitors.values.find(m => m.name === modelData.name)

            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            color: "transparent"

            implicitHeight: 40

            // Inside your main bar/panel file
            Item {
                id: barContainer
                anchors.fill: parent

                // 1. LEFT SIDE: Put things here you want on the left
                RowLayout {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 12

                    // Add logos, system info, etc. here
                }

                // 2. ABSOLUTE CENTER: The Workspaces Widget
                WorkspacesWidget {
                    id: centeredWorkspaces
                    // This is the key: it ignores the width of other items
                    anchors.centerIn: parent
                    monitor: hyprland_monitor
                }

                // 3. RIGHT SIDE: The Clock/Pill
                RowLayout {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 12

                    AudioWidget {}
                    ClockWidget {}
                }
            }
        }
    }
}
