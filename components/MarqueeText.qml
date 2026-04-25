import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.style
import qs.style.motions

Item {
    id: marqueeRoot

    required property string title
    property color textColor: Theme.primary
    property real textOpacity: 1
    readonly property int gap: Tokens.appearance.spacing.large

    readonly property int maxWidth: 200

    // 1. Define the threshold logic
    readonly property bool shouldScroll: text1.width > maxWidth

    Layout.preferredWidth: Math.min(text1.width, maxWidth)
    Layout.fillHeight: true
    clip: true

    SwapMotion on title {
        item: textRow
        // Only run the swap animation if we ALREADY have text.
        // If it's empty, update instantly so the parent pill can calculate its s
        enabled: text1.text !== ""
    }

    Item {
        id: maskSource
        anchors.fill: parent
        // 2. Show the raw source only if we AREN'T scrolling
        visible: !marqueeRoot.shouldScroll
        clip: true

        Row {
            id: textRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: marqueeRoot.gap

            StyledText {
                id: text1
                text: marqueeRoot.title
                color: marqueeRoot.textColor
                opacity: marqueeRoot.textOpacity
            }

            StyledText {
                id: text2
                text: marqueeRoot.title
                color: marqueeRoot.textColor
                opacity: marqueeRoot.textOpacity
                // 3. Only run the second text and animation if threshold is met
            }

            NumberAnimation on x {
                id: scrollAnim
                from: 0
                to: -(text1.width + marqueeRoot.gap)
                duration: 13000
                loops: Animation.Infinite
                running: marqueeRoot.shouldScroll // Simplified logic
            }
        }
    }

    // 4. Only enable the mask logic if the text is actually scrolling
    OpacityMask {
        anchors.fill: parent
        source: maskSource
        maskSource: maskGradient
        visible: marqueeRoot.shouldScroll
    }

    LinearGradient {
        id: maskGradient
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(marqueeRoot.width, 0)
        visible: false
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "transparent"
            }
            GradientStop {
                position: 0.08
                color: "black"
            }
            GradientStop {
                position: 0.85
                color: "black"
            }
            GradientStop {
                position: 1.0
                color: "transparent"
            }
        }
    }

    onTitleChanged: {
        textRow.x = 0;
        if (shouldScroll)
            scrollAnim.restart();
    }
}
