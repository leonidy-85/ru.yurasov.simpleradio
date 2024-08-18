import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: pageAbout

    SilicaFlickable {
        objectName: "flickable"
        anchors.fill: parent
//        contentHeight: layout.height + Theme.paddingLarge
        Column {
            id: col
            spacing: Theme.paddingLarge
            width: parent.width
            PageHeader {
                title: qsTr("About")
            }
            Label {
                text: qsTr("SimpleRadio")
                font.pixelSize: Theme.fontSizeExtraLarge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/usr/share/icons/hicolor/172x172/apps/ru.yurasov.simpleradio.png"
            }
            Label {
              text: qsTr("Version") + " " + version
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.secondaryHighlightColor
            }
            Label {
                text: qsTr("Application for listening to online stations")
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width
                horizontalAlignment: Text.Center
                textFormat: Text.RichText
                wrapMode: Text.Wrap
                color: Theme.secondaryColor
            }
            SectionHeader {
                text: qsTr("Author")
                visible: isPortrait || (largeScreen && Screen.width > 1080)
            }
            Label {
                text: qsTr("© Leonid Yurasov ") + buildyear
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Separator {
                color: Theme.primaryColor
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignHCenter
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2*Theme.horizontalPageMargin
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                text: qsTr("SimpleRadio is open source software licensed under the terms of the GNU General Public License.")
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 2*Theme.horizontalPageMargin
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                text: qsTr("For suggestions, bugs and ideas visit ")
            }
            Button {
                text: "GitHub"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: Qt.openUrlExternally("https://github.com/leonidy-85/ru.yurasov.SimpleRadio")
            }
//            Label {
//                objectName: "licenseText"
//                anchors { left: parent.left; right: parent.right; margins: Theme.horizontalPageMargin }
//                color: palette.highlightColor
//                font.pixelSize: Theme.fontSizeSmall
//                textFormat: Text.RichText
//                wrapMode: Text.WordWrap
//                text: qsTr("#licenseText")
//            }
        }
    }

}
