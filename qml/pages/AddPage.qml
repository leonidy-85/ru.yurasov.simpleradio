import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../db.js" as DB

Page {
    id: pageAdd
    PageHeader {
        objectName: "pageHeader"
        title: qsTr("Add station")
    }
    Flickable {
        id: flickable

        anchors.fill: parent
        contentWidth: parent.width

        Column {
            anchors.centerIn: parent
            height: parent.height - 200
            width: parent.width - 100
            spacing: 25

            Label {
                text: qsTr("Write the name of the radio station:")
            }

            TextField {
                id: name
                errorHighlight: false
                width: parent.width
                // height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: qsTr("")
            }

            Label {
                text: qsTr("Write the ip adress of the radio station:")
            }

            TextField {
                id: ip
                errorHighlight: false
                width: parent.width
                // height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: qsTr("")
            }

            Button {
                id: save
                width: parent.width
                text: qsTr("Save station")
                onClicked: {
                    DB.insert(name.text, ip.text)
                    save.text = qsTr("Station saved")
                }
            }
        }
    }
}
