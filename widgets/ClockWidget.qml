import QtQuick
import QtQuick.Layouts
import Quickshell.Networking

import qs.style
import qs.components
import qs.services

RowLayout {
    spacing: Tokens.appearance.spacing.smaller

    StyledText {
        text: Time.time
        color: Theme.primary
        font.bold: true
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
    }

    StyledText {
        text: Time.date
        font.pointSize: Tokens.appearance.fontSize.smaller
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
    }
}
