import QtQuick

Behavior {
    id: root
    property real duration: 100
    property real easingType: Easing.OutCubic
    
    NumberAnimation {
        duration: root.duration
        easing.type: root.easingType
    }
}
