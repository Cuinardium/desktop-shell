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

    readonly property bool shouldScroll: text1.width > maxWidth

    // Exposed so the scroll Component can compute its animation target
    // without depending on text1's id across a Component boundary.
    readonly property real singleTextWidth: text1.width

    Layout.preferredWidth: Math.min(text1.width, maxWidth)
    Layout.fillHeight: true
    clip: true

    SwapMotion on title {
        item: text1
        enabled: text1.text !== ""
    }

    // --- Static display (not scrolling) ---
    Item {
        id: staticView
        anchors.fill: parent
        visible: !marqueeRoot.shouldScroll
        clip: true

        StyledText {
            id: text1
            anchors.verticalCenter: parent.verticalCenter
            text: marqueeRoot.title
            color: marqueeRoot.textColor
            opacity: marqueeRoot.textOpacity
        }
    }

    // --- Scroll display: fully self-contained, lazy loaded ---
    Loader {
        id: scrollLoader
        anchors.fill: parent
        active: marqueeRoot.shouldScroll
        sourceComponent: scrollComponent
    }

    Component {
        id: scrollComponent

        Item {
            clip: true

            // Source item for OpacityMask. layer.enabled forces FBO population
            // even with visible: false, so the mask shader has a valid texture.
            Item {
                id: scrollSource
                anchors.fill: parent
                visible: false
                layer.enabled: true

                Row {
                    id: scrollRow
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: marqueeRoot.gap

                    StyledText {
                        text: marqueeRoot.title
                        color: marqueeRoot.textColor
                        opacity: marqueeRoot.textOpacity
                    }
                    StyledText {
                        text: marqueeRoot.title
                        color: marqueeRoot.textColor
                        opacity: marqueeRoot.textOpacity
                    }
                }
            }

            NumberAnimation {
                id: scrollAnim
                target: scrollRow
                property: "x"
                from: 0
                to: -(marqueeRoot.singleTextWidth + marqueeRoot.gap)
                duration: 13000
                loops: Animation.Infinite
                running: true
            }

            LinearGradient {
                id: localGradient
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(parent.width, 0)
                visible: false
                gradient: Gradient {
                    GradientStop { position: 0.0;  color: "transparent" }
                    GradientStop { position: 0.08; color: "black" }
                    GradientStop { position: 0.85; color: "black" }
                    GradientStop { position: 1.0;  color: "transparent" }
                }
            }

            OpacityMask {
                anchors.fill: parent
                source: scrollSource
                maskSource: localGradient
            }

            Connections {
                target: marqueeRoot
                function onTitleChanged() {
                    scrollRow.x = 0;
                    scrollAnim.restart();
                }
            }
        }
    }
}
