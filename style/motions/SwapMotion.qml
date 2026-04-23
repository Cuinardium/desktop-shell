import QtQuick
import qs.style

Behavior {
    id: root
    property real outDuration: 100
    property real inDuration: 200
    property var item: targetItem
    property string prop: targetProperty

    SequentialAnimation {
        // Fade out
        Anim {
            target: item
            property: "opacity"
            to: 0
            duration: Tokens.appearance.animDurations.small
            easing.bezierCurve: Tokens.appearance.curves.standardAccel
        }

        // Instant swap
        PropertyAction {
            target: item
            property: prop
        }

        // Fade in
        NumberAnimation {
            target: item
            property: "opacity"
            to: 1
            duration: Tokens.appearance.animDurations.normal
            easing.bezierCurve: Tokens.appearance.curves.standardDecel
        }
    }
}
