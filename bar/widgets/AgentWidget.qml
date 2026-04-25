import QtQuick
import QtQuick.Layouts

import qs.components
import qs.style

Item {
    id: root

    implicitWidth: icon.width + Tokens.appearance.padding.smaller
    implicitHeight: icon.height + Tokens.appearance.padding.smaller
    Layout.alignment: Qt.AlignVCenter

    MaterialIcon {
        id: icon
        text: "robot_2"
        color: Theme.primary
        anchors.centerIn: parent
    }

    StateLayer {
        effectColor: Theme.primary
        radius: Tokens.appearance.rounding.extraSmall
    }
}
