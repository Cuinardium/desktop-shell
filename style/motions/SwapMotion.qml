import QtQuick

Behavior {
    id: root
    property real outDuration: 100
    property real inDuration: 200
    property var item: targetItem
    property string prop: targetProperty

    SequentialAnimation {
        // Fade out
        NumberAnimation { 
            target: item; property: "opacity"; 
            to: 0; duration: root.outDuration
        }
        
        // Instant swap
        PropertyAction { target: item; property: prop }
        
        // Fade in
        NumberAnimation { 
            target: item; property: "opacity"; 
            to: 1; duration: root.inDuration
        }
    }
}
