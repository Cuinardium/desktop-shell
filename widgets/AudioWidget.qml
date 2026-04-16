import QtQuick

import "../components"
import "../services" as Services
import "../style"
import "../style/motions"

ClickablePill {
    id: root
    onClicked: Services.Audio.toggleMute()
    onWheeled: wheel => {
        if (wheel.angleDelta.y > 0)
            Services.Audio.adjustVolume(0.02);
        else
            Services.Audio.adjustVolume(-0.02);
    }

    property real animatedVolume: Services.Audio.volume
    NumberMotion on animatedVolume {}

    readonly property string icon: Services.Audio.muted ? "󰝟" : animatedVolume > 0 ? (animatedVolume <= 0.4 ? "" : "") : ""
    readonly property string volume_text: Math.round(animatedVolume * 100) + "%"

    Item {
        implicitWidth: 15
        height: iconText.height

        Text {
            id: iconText
            anchors.centerIn: parent
            text: icon
            color: Services.Audio.muted ? Theme.error : Theme.primary
            font.pixelSize: 26

            SwapMotion on text {
                item: iconText
                prop: "text"
            }
            ColorMotion on color {}
        }
    }

    // Volume Text Container
    Item {
        implicitWidth: 25

        height: volumeLabel.height

        Text {
            id: volumeLabel
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            text: volume_text
            color: Theme.on_surface
        }
    }
}
