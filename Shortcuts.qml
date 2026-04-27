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

    GlobalShortcut {
        name: "toggle-run-menu"
        description: "Open the app launcher"
        onPressed: ShellState.runMenuOpen = !ShellState.runMenuOpen
    }

    // You can easily drop volume, brightness, or screenshot shortcuts here later
}
