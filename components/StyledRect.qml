import QtQuick
import qs.style.motions

Rectangle {
    id: root

    color: "transparent"

    Behavior on color {
        Anim {}
    }
}
