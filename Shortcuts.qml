pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
import qs

Item {
    id: shortcutsRoot

    GlobalShortcut {
        name: "toggle-power-menu"
        description: "Open the power menu"
        onPressed: ShellState.powerMenuOpen = !ShellState.powerMenuOpen
    }

    // You can easily drop volume, brightness, or screenshot shortcuts here later
}
