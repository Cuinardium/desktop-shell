import QtQuick
import QtQuick.Layouts

import Quickshell.Networking

import qs.components
import qs.style

RowLayout {
    readonly property var devices: Networking.devices.values
    property var currentDevice: null
    property var connectivity: Networking.connectivity

    function updateCurrentDevice() {
        currentDevice = devices.find(device => device.connected) ?? null;
    }

    Component.onCompleted: updateCurrentDevice()
    onDevicesChanged: updateCurrentDevice()

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
