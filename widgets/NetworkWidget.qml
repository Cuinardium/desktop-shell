import QtQuick

import "../components"
import "../style"
import "../services/networking" as Networking

Pill {
    Text {
        color: Theme.primary
        font {
            bold: true
            pixelSize: 22
        }
        text: "󰌗"
        opacity: Networking.Ethernet.available ? 1 : 0
    }

    Text {
        color: Theme.primary
        font {
            bold: true
            pixelSize: Tokens.font.size.normal
        }
        text: Networking.Ethernet.connectivity
        opacity: Networking.Ethernet.available ? 1 : 0
    }
}
