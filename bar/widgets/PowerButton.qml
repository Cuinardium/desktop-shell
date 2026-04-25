import QtQuick
import qs.style
import qs.components
import qs.services
import qs

Item {
    id: root

    implicitWidth: 32
    implicitHeight: 32

    // Estado del menú
    readonly property bool menuOpen: ShellState.powerMenuOpen

    // El botón en la barra
    Rectangle {
        anchors.fill: parent
        radius: Tokens.appearance.rounding.full
        color: root.menuOpen ? Theme.surface_container_high : Theme.surface_container

        Behavior on color {
            ColorAnimation {
                duration: Tokens.appearance.animDurations.expressiveFastEffects
                easing.type: Easing.Bezier
                easing.bezierCurve: Tokens.appearance.curves.standard
            }
        }

        MaterialIcon {
            anchors.centerIn: parent
            text: "power_settings_new"
            color: root.menuOpen ? Theme.error : Theme.primary
            fill: root.menuOpen ? 1 : 0

            Behavior on color {
                ColorAnimation { duration: Tokens.appearance.animDurations.expressiveFastEffects }
            }
        }

        StateLayer {
            anchors.fill: parent
            radius: Tokens.appearance.rounding.full
            onClicked: ShellState.powerMenuOpen = !ShellState.powerMenuOpen
        }
    }
}
