import QtQuick
import QtQuick.Shapes
import qs.style
import qs.style.motions
import qs.components

Item {
    id: root
    
    property real progress: 0.0 
    property string iconName: "play_arrow"
    
    implicitWidth: innerIcon.implicitWidth + Tokens.appearance.padding.medium
    implicitHeight: implicitWidth

    signal clicked()

    // Drawing both paths in the same Shape guarantees they use 
    // the exact same coordinate math and rendering pipeline.
    Shape {
        id: canvas
        anchors.fill: parent
        
        // Forces hardware-accelerated, ultra-smooth curves
        preferredRendererType: Shape.CurveRenderer
        antialiasing: true

        // 1. The Empty Background Track (Replaces the Rectangle)
        ShapePath {
            fillColor: "transparent"
            strokeColor: Qt.alpha(Theme.primary, 0.15)
            strokeWidth: 2
            capStyle: ShapePath.RoundCap

            startX: canvas.width / 2
            startY: (canvas.height / 2) - (canvas.width / 2 - 1)

            PathAngleArc {
                centerX: canvas.width / 2
                centerY: canvas.height / 2
                radiusX: canvas.width / 2 - 1
                radiusY: canvas.height / 2 - 1
                startAngle: -90
                sweepAngle: 360 // Draw a full circle
            }
        }

        // 2. The Active Progress Arc
        ShapePath {
            fillColor: "transparent" 
            strokeColor: Theme.primary
            strokeWidth: 2
            capStyle: ShapePath.RoundCap

            startX: canvas.width / 2
            startY: (canvas.height / 2) - (canvas.width / 2 - 1)

            PathAngleArc {
                centerX: canvas.width / 2
                centerY: canvas.height / 2
                radiusX: canvas.width / 2 - 1
                radiusY: canvas.height / 2 - 1
                startAngle: -90
                
                // Keep it capped safely
                sweepAngle: Math.max(0, Math.min(360, root.progress * 360))
            }
        }
    }

    MaterialIcon {
        id: innerIcon
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 1

        text: root.iconName
        color: Theme.primary
        font.pointSize: 10

        SwapMotion on text {
            item: innerIcon
            prop: "text"
        }
    }

    StateLayer {
        radius: Tokens.appearance.rounding.full
        effectColor: Theme.primary
        onClicked: root.clicked()
    }
}
