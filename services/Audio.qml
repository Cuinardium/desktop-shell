pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    readonly property real volume: Pipewire.defaultAudioSink.audio.volume
    readonly property bool muted: Pipewire.defaultAudioSink.audio.muted

    PwObjectTracker {
        id: sinkTracker
        objects: [Pipewire.defaultAudioSink]
    }

    function toggleMute() {
        const audio = Pipewire.defaultAudioSink?.audio;
        if (audio) {
            audio.muted = !audio.muted;
        }
    }

    function adjustVolume(delta) {
        const audio = Pipewire.defaultAudioSink?.audio;
        if (audio) {
            let newVol = audio.volume + delta;
            audio.volume = Math.max(0, Math.min(newVol, 1.0));
        }
    }
}
