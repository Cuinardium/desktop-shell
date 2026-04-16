import QtQuick
import QtQuick.Layouts
import "../style"

Rectangle {
    id: root
    default property alias content: container.data
    
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
}
