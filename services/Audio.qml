pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    readonly property real volume: sinkTracker.objects[0]?.audio?.volume || 0
    readonly property bool muted: sinkTracker.objects[0]?.audio?.muted || false

    readonly property var programs: programsTracker.objects

    PwObjectTracker {
        id: sinkTracker
        objects: [Pipewire.defaultAudioSink]
    }

    PwObjectTracker {
        id: programsTracker
        objects: Pipewire.nodes.values.filter(node => node.isStream)
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
