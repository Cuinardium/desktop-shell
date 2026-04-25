import QtQuick
import QtQuick.Layouts
import Quickshell.Networking

import qs.style
import qs.components
import qs.services

RowLayout {
    property bool showDate: true
    spacing: Tokens.appearance.spacing.smaller

    StyledText {
        text: Time.time
        color: Theme.primary
        font.bold: true
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        radius: Tokens.appearance.rounding.full
        color: Theme.primary
        Layout.preferredWidth: 4
        Layout.preferredHeight: 4
        visible: showDate
    }

    StyledText {
        text: Time.date
        font.pointSize: Tokens.appearance.fontSize.smaller
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
        visible: showDate
    }
}
