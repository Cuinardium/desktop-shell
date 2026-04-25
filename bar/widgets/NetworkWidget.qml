import QtQuick
import QtQuick.Layouts

import Quickshell.Networking

import qs.components
import qs.style

RowLayout {
    property var currentDevice: Networking.devices.values.find(d => d.connected)
    property var connectivity: Networking.connectivity

    property string icon: currentDevice.type === DeviceType.Wired ? "lan" : "wifi"

    MaterialIcon {
        color: Theme.primary
        text: icon
    }

    StyledText {
        text: currentDevice.name
    }
}
