import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.style

Item {
    id: marqueeRoot

    required property string title
    property color textColor: Theme.primary
    property real textOpacity: 1
    readonly property int gap: Tokens.appearance.spacing.large // Space between loops


    Layout.preferredWidth: 200
    Layout.fillHeight: true
    clip: true

    Item {
        id: maskSource
        anchors.fill: parent
        visible: false
        clip: true

        Row {
            id: textRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: marqueeRoot.gap

            // First instance of the text
            StyledText {
                id: text1
                text: marqueeRoot.title
                color: marqueeRoot.textColor
                opacity: marqueeRoot.textOpacity
            }

            // Second instance (the one that follows immediately)
            StyledText {
                id: text2
                text: marqueeRoot.title
                color: marqueeRoot.textColor
                opacity: marqueeRoot.textOpacity

                // Only visible if the text is actually long enough to scroll
                visible: scrollAnim.running
            }

            NumberAnimation on x {
                id: scrollAnim
                from: 0
                // Move by the width of one text item + the gap
                to: -(text1.width + marqueeRoot.gap)
                duration: 20000
                loops: Animation.Infinite
                // Only run if the text is wider than the container
                running: text1.width > marqueeRoot.width
            }
        }
    }

    LinearGradient {
        id: maskGradient
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(marqueeRoot.width, 0)
        visible: false
        gradient: Gradient {
            // 1. Soft Entrance: The text fades in quickly after the icon
            GradientStop {
                position: 0.0
                color: "transparent"
            }
            GradientStop {
                position: 0.08
                color: "black"
            }

            // 2. Solid Middle
            GradientStop {
                position: 0.85
                color: "black"
            }

            // 3. Soft Exit: The text fades out into the bar
            GradientStop {
                position: 1.0
                color: "transparent"
            }
        }
    }

    OpacityMask {
        anchors.fill: parent
        source: maskSource
        maskSource: maskGradient
    }

    // Reset the animation whenever the song changes
    onTitleChanged: {
        textRow.x = 0;
        scrollAnim.restart();
    }
}
