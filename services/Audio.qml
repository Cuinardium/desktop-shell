pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root
    
    // Create safe intermediate references
    readonly property var activeSink: sinkTracker.objects.length > 0 ? sinkTracker.objects[0] : null
    readonly property var sinkAudio: activeSink ? activeSink.audio : null

    // Safe bindings that react to the tracker
    readonly property real volume: sinkAudio ? sinkAudio.volume : 0
    readonly property bool muted: sinkAudio ? sinkAudio.muted : false

    readonly property var programs: programsTracker.objects

    PwObjectTracker {
        id: sinkTracker
        objects: Pipewire.defaultAudioSink ? [Pipewire.defaultAudioSink] : []
    }

    PwObjectTracker {
        id: programsTracker
        objects: Pipewire.nodes.values.filter(node => node.isStream)
    }

    function toggleMute() {
        if (sinkAudio) {
            sinkAudio.muted = !sinkAudio.muted;
        }
    }

    function adjustVolume(delta) {
        if (sinkAudio) {
            let newVol = sinkAudio.volume + delta;
            sinkAudio.volume = Math.max(0, Math.min(newVol, 1.0));
        }
    }
}
