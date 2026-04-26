import QtQuick
import QtQuick.Layouts

import Quickshell.Networking

import qs.components
import qs.style

RowLayout {
    property var currentDevice: (Networking.devices.values.find(d => d.connected)) ?? null
    property var connectivity: Networking.connectivity

    property string icon: !currentDevice ? "wifi" : (currentDevice.type === DeviceType.Wired ? "lan" : "wifi")

    MaterialIcon {
        color: Theme.primary
        text: icon
        visible: !!currentDevice
    }

    StyledText {
        text: currentDevice?.name ?? ""
        visible: !!currentDevice
    }
}
