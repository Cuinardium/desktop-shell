import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services
import qs.style
import qs.style.motions

RowLayout {
    id: root

    property real animatedVolume: Audio.volume
    Behavior on animatedVolume {
        Anim {
            type: Anim.Type.StandardSmall
        }
    }

    readonly property string icon: Audio.muted ? "volume_off" : animatedVolume > 0 ? (animatedVolume <= 0.4 ? "volume_down" : "volume_up") : "volume_mute"
    readonly property string volume_text: Math.round(animatedVolume * 100) + "%"

    MaterialIcon {
        id: volumeIcon
        Layout.leftMargin: Tokens.appearance.padding.smaller
        text: icon
        color: Audio.muted ? Theme.error : Theme.primary
        SwapMotion on text {
            item: volumeIcon
            prop: "text"
        }
        Behavior on color {
            Anim {
                type: Anim.Type.StandardSmall
            }
        }
    }

    // Volume Text Container
    Item {
        Layout.rightMargin: Tokens.appearance.padding.smaller
        implicitWidth: 30

        height: volumeLabel.height

        StyledText {
            id: volumeLabel
            Layout.alignment: Qt.AlignRight
            text: volume_text
        }
    }

    StateLayer {
        effectColor: Theme.primary
        radius: Tokens.appearance.rounding.extraSmall

        onClicked: Audio.toggleMute()
        onWheeled: wheel => {
            if (wheel.angleDelta.y > 0)
                Audio.adjustVolume(0.02);
            else
                Audio.adjustVolume(-0.02);
        }
    }
}
