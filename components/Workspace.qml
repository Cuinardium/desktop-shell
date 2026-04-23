import QtQuick

import qs.style
import qs.style.motions
import qs.util

Rectangle {
    id: root

    required property var modelData
    required property string currentMonitorName

    // --- Data Bindings ---
    readonly property bool isActive: modelData ? modelData.active : false
    readonly property bool isFocused: modelData ? modelData.focused : false
    readonly property var windows: modelData ? modelData.toplevels.values : []
    readonly property bool isEmpty: windows.length === 0
    readonly property string icons: windows.slice(0, 3).map(t => IconMap.getMatch(t.wayland.appId).icon).join(" ")

    visible: modelData ? (modelData.monitor.name === currentMonitorName) : false

    // --- Sizing ---
    implicitHeight: 30
    readonly property real targetWidth: isEmpty ? implicitHeight : iconText.width + 24
    property real animatedWidth: targetWidth
    
    Behavior on animatedWidth {
        Anim { type: Anim.DefaultSpatial }
    }

    width: animatedWidth
    implicitWidth: animatedWidth
    
    radius: Tokens.appearance.rounding.full
    clip: true

    // --- Styling ---
    color: isFocused ? Qt.alpha(Theme.primary, 0.15) : "transparent"

    Behavior on color {
        Anim { type: Anim.DefaultSpatial }
    }

    // --- Content Container ---
    Item {
        anchors.fill: parent
        
        // 1. Window Icons
        Text {
            id: iconText
            anchors.centerIn: parent
            visible: !root.isEmpty
            
            color: isFocused ? Theme.primary : Theme.secondary
            text: root.icons
            
            font.bold: true
            font.pixelSize: 22
            
            opacity: root.isEmpty ? 0 : 1
            scale: root.isEmpty ? 0.5 : (root.isFocused ? 1.1 : 1.0)

            Behavior on scale {
                Anim { type: Anim.DefaultSpatial }
            }
            Behavior on opacity {
                Anim { type: Anim.DefaultSpatial }
            }
        }

        // 2. Central Dot (Empty indicator)
        Rectangle {
            id: emptyIndicator
            anchors.centerIn: parent
            visible: root.isEmpty
            
            width: 10
            height: 10
            radius: width / 2

            color: root.isFocused ? Theme.primary : Theme.outline_variant
            
            opacity: root.isEmpty ? 1 : 0
            scale: root.isEmpty ? (root.isFocused ? 1.2 : 1.0) : 0.5

            Behavior on scale {
                Anim { type: Anim.DefaultSpatial }
            }
            Behavior on opacity {
                Anim { type: Anim.DefaultSpatial }
            }
            Behavior on color {
                Anim { type: Anim.DefaultSpatial }
            }
        }
    }

    // --- Interaction ---
    StateLayer {
        effectColor: Theme.primary
        radius: root.radius 
        
        onClicked: {
            if (root.modelData) root.modelData.activate()
        }
    }
}
