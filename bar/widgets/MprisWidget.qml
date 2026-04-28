import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Mpris

import qs.services
import qs.components
import qs.style
import qs.style.motions

Rectangle {
    id: pill

    property var playerIndex: 0

    property var activePlayer: Mpris.players.values?.[playerIndex] ?? null

    readonly property bool isActive: activePlayer != null

    // ── Capability flags — siempre derivados del player activo ─────────────
    readonly property bool canTogglePlaying: isActive && activePlayer.canTogglePlaying
    readonly property bool canGoNext: isActive && activePlayer.canGoNext
    readonly property bool canGoPrevious: isActive && activePlayer.canGoPrevious
    readonly property bool canSeek: isActive && activePlayer.canSeek
    readonly property bool hasProgress: isActive && activePlayer.lengthSupported && activePlayer.positionSupported && activePlayer.length > 0

    // ── Layout ─────────────────────────────────────────────────────────────
    implicitWidth: root.implicitWidth + (Tokens.appearance.padding.small * 2)
    implicitHeight: root.implicitHeight + Tokens.appearance.padding.small

    Layout.preferredWidth: isActive ? implicitWidth : 0
    opacity: isActive ? 1 : 0
    clip: true
    visible: width > 0 || opacity > 0

    color: Theme.surface_container
    radius: Tokens.appearance.rounding.full

    Behavior on Layout.preferredWidth {
        Anim {
            type: Anim.EmphasizedExtraLarge
        }
    }
    Behavior on opacity {
        Anim {
            type: Anim.Standard
        }
    }

    Timer {
        running: pill.activePlayer?.playbackState === MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: pill.activePlayer?.positionChanged()
    }

    RowLayout {
        id: root
        spacing: Tokens.appearance.spacing.smaller
        anchors.left: parent.left
        anchors.leftMargin: Tokens.appearance.padding.small
        anchors.verticalCenter: parent.verticalCenter

        // ── Play / Pause ───────────────────────────────────────────────────
        ProgressIcon {
            id: playPauseIcon

            clickable: pill.canTogglePlaying || pill.canSeek
            verticalOffset: 1
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 22
            Layout.preferredHeight: 22

            progress: pill.hasProgress ? pill.activePlayer.position / pill.activePlayer.length : 1

            Behavior on progress {
                Anim {
                    type: Anim.Standard
                }
            }

            // Debounce: evita que el ícono parpadee al cambiar de track.
            property bool debouncedPlaying: pill.activePlayer?.isPlaying ?? false

            Timer {
                id: debounceTimer
                interval: 200
                onTriggered: playPauseIcon.debouncedPlaying = false
            }
            Connections {
                target: pill
                function onActivePlayerChanged() {
                    debounceTimer.stop();
                    playPauseIcon.debouncedPlaying = pill.activePlayer?.isPlaying ?? false;
                }
            }

            Connections {
                target: pill.activePlayer
                enabled: pill.activePlayer != null
                function onPlaybackStateChanged() {
                    if (!pill.activePlayer)
                        return;
                    if (pill.activePlayer.isPlaying) {
                        debounceTimer.stop();
                        playPauseIcon.debouncedPlaying = true;
                    } else {
                        debounceTimer.restart();
                    }
                }
            }

            iconName: playPauseIcon.debouncedPlaying ? "pause" : "play_arrow"
            onClicked: pill.activePlayer?.togglePlaying()
            onWheeled: wheel => {
                if (!pill.canSeek)
                    return;
                // anngleDelta.y: 120 per stantdard wheel notch in most mouses -> 5s per notch
                const notches = wheel.angleDelta.y / 120;
                pill.activePlayer?.seek(notches * 5);
            }
        }

        MarqueeText {
            title: pill.activePlayer?.trackTitle ?? ""
            Layout.maximumWidth: maxWidth
            scrollEnabled: Mpris?.players.values.length > 1
            onWheeled: wheel => {
                const playerCount = Mpris?.players.values.length ?? 0;
                var newIndex = pill.playerIndex + (wheel.angleDelta.y > 0 ? 1 : -1);
                if (newIndex < 0)
                    newIndex = playerCount - 1;
                else if (newIndex >= playerCount)
                    newIndex = 0;

                pill.playerIndex = newIndex;
            }
        }
    }
}
