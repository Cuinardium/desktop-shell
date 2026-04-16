import QtQuick
import QtQuick.Layouts
import "../style"
import "../style/motions"

Rectangle {
    id: root
    default property alias content: container.data

    // Add a signal for the widget to use
    signal clicked
    signal wheeled(var wheel)

    property bool containsMouse: mouseArea.containsMouse

    property color backgroundColor: Theme.surface_container_low
    property color borderColor: Theme.outline_variant
    property real borderWidth: 2
    property real padding: 8

    implicitHeight: 30
    width: container.implicitWidth + (padding * 2)
    radius: height / 2

    color: backgroundColor
    border.color: borderColor
    border.width: borderWidth

    // This centers the icons/dots automatically
    RowLayout {
        id: container
        anchors.centerIn: parent // Use parent instead of root to be safe
        spacing: 6
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
        onWheel: wheel => root.wheeled(wheel)
    }

    // Scale the pill slightly on hover
    scale: mouseArea.containsMouse ? 1.05 : 1.0
    NumberMotion on scale {}
}
