pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import qs.panels.power_menu
import qs.panels.run

Item {
    id: panelsRoot

    // Accept the screen string from the main shell
    property string targetScreen: ""

    PowerMenuPanel {
        id: powerMenuPanel
        screen: Quickshell.screens.find(s => s.name === panelsRoot.targetScreen)
        // Note: Make sure PowerMenuPanel internally binds its visibility/animations to ShellState.powerMenuOpen
    }
}
