import QtQuick
import Quickshell.Networking

import "../style"
import "../components"
import "../services/networking" as Networking
import "../services" as Services 

Pill {
    Text {
        text: Services.Time.date
        color: Theme.on_surface
        font.pixelSize: 14
    }

    Divider {}

    Text {
        text: Services.Time.time
        color: Theme.primary
        font.pixelSize: 14
        font.bold: true
    }
}
