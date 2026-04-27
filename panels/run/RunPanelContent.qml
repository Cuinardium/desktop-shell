pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.components
import qs.style
import qs

Item {
    id: root
    anchors.fill: parent

    property var filteredApps: []

    function updateFilter() {
        var term = searchField.text.toLowerCase()
        var results = []
        var allEntries = DesktopEntries.applications.values
        for (var i = 0; i < allEntries.length; i++) {
            var entry = allEntries[i]
            if (entry.name.toLowerCase().indexOf(term) !== -1 ||
               (entry.genericName && entry.genericName.toLowerCase().indexOf(term) !== -1)) {
                results.push(entry)
            }
        }
        filteredApps = results
        appList.currentIndex = 0
    }

    Connections {
        target: DesktopEntries
        function onApplicationsChanged() { root.updateFilter() }
    }

    Connections {
        target: ShellState
        function onRunMenuOpenChanged() {
            if (ShellState.runMenuOpen) {
                searchField.text = ""
                searchField.forceActiveFocus()
            }
        }
    }

    Component.onCompleted: updateFilter()

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ListView {
            id: appList
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            spacing: 2

            model: root.filteredApps

            preferredHighlightBegin: 0
            preferredHighlightEnd: height - 56
            highlightRangeMode: ListView.ApplyRange

            delegate: Rectangle {
                id: delegateItem
                required property var modelData
                required property int index

                width: ListView.view.width
                height: 56
                radius: Tokens.appearance.rounding.small
                color: ListView.isCurrentItem ? Theme.surface_container_high : "transparent"
                property bool selected: ListView.isCurrentItem

                StateLayer {
                    id: stateLayer
                    effectColor: Theme.primary
                    onClicked: root.launch(delegateItem.index)
    
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 12
                    anchors.topMargin: 8
                    anchors.bottomMargin: 8
                    spacing: 12

                    Rectangle {
                        width: 40
                        height: 40
                        radius: 20
                        color: "transparent"
                        clip: true

                        Image {
                            anchors.fill: parent
                            anchors.margins: 4
                            source: delegateItem.modelData.icon ? ("image://icon/" + delegateItem.modelData.icon) : ""
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                            mipmap: true
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 1

                        StyledText {
                            Layout.fillWidth: true
                            text: delegateItem.modelData.name
                            color: delegateItem.selected ? Theme.primary : Theme.on_surface
                            font.pixelSize: Tokens.appearance.fontSize.normal
                            font.weight: Font.Medium
                            elide: Text.ElideRight
                        }

                        StyledText {
                            Layout.fillWidth: true
                            text: delegateItem.modelData.genericName || ""
                            color: Theme.on_surface_variant
                            font.pixelSize: Tokens.appearance.fontSize.small
                            elide: Text.ElideRight
                            visible: text.length > 0
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 44
            Layout.bottomMargin: 8
            Layout.topMargin: 8
            radius: Tokens.appearance.rounding.full
            color: Qt.alpha(Theme.primary, 0.12)

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 14
                spacing: 8

                MaterialIcon {
                    text: "search"
                    font.pixelSize: Tokens.appearance.fontSize.larger
                    color: Theme.primary
                    verticalAlignment: Text.AlignVCenter
                }

                TextInput {
                    id: searchField
                    Layout.fillWidth: true
                    verticalAlignment: TextInput.AlignVCenter
                    color: Theme.on_surface_variant
                    font.pixelSize: Tokens.appearance.fontSize.large
                    font.family: Tokens.appearance.fontFamily.sans
                    clip: true
                    focus: true

                    StyledText {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Search apps..."
                        color: Theme.on_surface_variant
                        visible: !parent.text
                    }

                    onTextChanged: root.updateFilter()

                    Keys.onDownPressed: { appList.incrementCurrentIndex(); (event) => event.accepted = true }
                    Keys.onUpPressed: { appList.decrementCurrentIndex(); (event) => event.accepted = true }
                    Keys.onTabPressed: { appList.incrementCurrentIndex(); (event) => event.accepted = true }
                    Keys.onBacktabPressed: { appList.decrementCurrentIndex(); (event) => event.accepted = true }
                    Keys.onReturnPressed: { root.launchCurrent(); (event) => event.accepted = true }
                }

                MaterialIcon {
                    text: "close"
                    font.pixelSize: Tokens.appearance.fontSize.normal
                    color: Theme.on_surface_variant
                    verticalAlignment: Text.AlignVCenter
                    visible: searchField.text.length > 0

                    StateLayer {
                        onClicked: searchField.text = ""
                    }
                }
            }
        }
    }

    function launch(index) {
        if (filteredApps.length > 0 && index >= 0) {
            filteredApps[index].execute()
            ShellState.runMenuOpen = false
            searchField.text = ""
        }
    }

    function launchCurrent() {
        if (filteredApps.length > 0 && appList.currentIndex >= 0) {
            filteredApps[appList.currentIndex].execute()
            ShellState.runMenuOpen = false
            searchField.text = ""
        }
    }
}
