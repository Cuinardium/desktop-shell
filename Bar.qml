import Quickshell // for PanelWindow
import Quickshell.Hyprland // for HyprlandMonitor
import Quickshell.Networking
import QtQuick // for Text
import QtQuick.Layouts

import qs.widgets
import qs.style
import qs.components

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            required property var modelData
            property HyprlandMonitor hyprland_monitor: Hyprland.monitors.values.find(m => m.name === modelData.name)

                    property var index: 0

            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 40
            color: "transparent"

            BarBackground {}

            // Inside your main bar/panel file
            Item {
                id: barContainer
                anchors.fill: parent
                anchors.leftMargin: Tokens.appearance.padding.larger
                anchors.rightMargin: Tokens.appearance.padding.larger

                // 1. LEFT SIDE: Put things here you want on the left
                RowLayout {
                    anchors.left: parent.left
                    anchors.leftMargin: Tokens.appearance.padding.small
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: Tokens.appearance.spacing.small

                    // Add logos, system info, etc. here
                    AgentWidget {}
                    MprisWidget {}
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
                    anchors.rightMargin: Tokens.appearance.padding.small
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    spacing: Tokens.appearance.spacing.small

                    RowLayout {
                        spacing: Tokens.appearance.spacing.smaller
                        NetworkWidget {}
                        AudioWidget {}
                    }
                    Divider {
                        Layout.preferredHeight: bar.height * 0.6
                    }
                    ClockWidget {}
                }
            }
        }
    }
}
