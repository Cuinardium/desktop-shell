pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.style
import qs.style.motions

// Responsabilidad única: orquestar el estado y componer los subcomponentes.
// No contiene lógica de renderizado — delega en WorkspacePill y WorkspaceSlidingBackground.
Item {
    id: root

    required property HyprlandMonitor monitor

    implicitWidth: row.implicitWidth + 16
    implicitHeight: row.implicitHeight + 8

    // --- Estado puro: datos escalares, sin referencias a Items hijos ---
    // Esto elimina el acoplamiento que causaba el Binding { target: workspacesRoot }
    property real activePillLocalX: 0
    property real activePillX: row.x + activePillLocalX
    property real activePillWidth: 0
    property bool activePillExists: false  // hay algún pill enfocado en este monitor

    // --- Fondo contenedor ---
    Rectangle {
        anchors.fill: parent
        color: Theme.surface_container
        radius: Tokens.appearance.rounding.full
    }

    // --- Fondo deslizante (recibe solo datos, no referencias) ---
    WorkspaceSlidingBackground {
        targetX: root.activePillX
        targetWidth: root.activePillWidth
        isFocused: root.activePillExists
        rowY: row.y
        rowHeight: row.height
    }

    // --- Pills de workspaces ---
    Row {
        id: row
        anchors.centerIn: parent
        spacing: Tokens.appearance.spacing.small

        Repeater {
            model: Hyprland.workspaces

            WorkspacePill {
                monitor: root.monitor

                // El hijo sube datos mediante señal; el padre actualiza su estado.
                // Flujo unidireccional: hijo → señal → padre actualiza propiedades escalares.
                onFocusedGeometryChanged: (pillX, pillWidth) => {
                    root.activePillLocalX = pillX;
                    root.activePillWidth = pillWidth;
                    root.activePillExists = true;
                }

                // Cuando un pill pierde el foco, verificar si aún hay uno enfocado
                // (cubre el caso de cambio de monitor)
                onIsFocusedChanged: {
                    if (!isFocused) {
                        // Si ningún otro pill reportó foco, ocultar el slider
                        Qt.callLater(() => {
                            root.activePillExists = Hyprland.workspaces.values.some(ws => ws.focused && ws.monitor.name === root.monitor.name);
                        });
                    }
                }
            }
        }
    }
}
