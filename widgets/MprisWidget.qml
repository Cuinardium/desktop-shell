import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import Quickshell.Services.Mpris

import qs.services
import qs.components
import qs.style

Rectangle {
    id: pill

    // The size will now perfectly wrap the contents + padding
    implicitWidth: root.implicitWidth + (Tokens.appearance.padding.small * 2)
    implicitHeight: root.implicitHeight + Tokens.appearance.padding.small

    color: Qt.alpha(Theme.primary, 0.15)
    radius: Tokens.appearance.rounding.full

    property var activePlayer: Mpris.players.values[0]

    Timer {
        running: pill.activePlayer?.playbackState === MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: pill.activePlayer?.positionChanged()
    }

    RowLayout {
        id: root
        spacing: Tokens.appearance.spacing.smaller
        anchors.centerIn: parent

        ProgressIcon {
            id: icon
            Layout.alignment: Qt.AlignVCenter

            Layout.preferredWidth: 22
            Layout.preferredHeight: 22

            // Calculate progress (protect against division by zero)
            progress: {
                if (!pill.activePlayer || !pill.activePlayer.lengthSupported || !pill.activePlayer.positionSupported || pill.activePlayer.length === 0) {
                    return 1;
                }

                return pill.activePlayer.position / pill.activePlayer.length;
            }

            // Change icon based on state
            iconName: pill.activePlayer?.playbackState === MprisPlaybackState.Playing ? "pause" : "play_arrow"

            onClicked: pill.activePlayer?.togglePlaying()
        }

        MarqueeText {
            id: marqueeRoot
            title: Mpris.players.values[0].trackTitle
        }
    }
}
