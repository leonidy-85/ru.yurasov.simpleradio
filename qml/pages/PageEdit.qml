import QtQuick 2.4
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0
import "../db.js" as DB

Page {
    id: stantionUpdate

    property string name
    property string ip
    property string id

    PageHeader {
        objectName: "stantionUpdate"
        title: qsTr("Edit Stantion")
    }

    Flickable {
        id: flickable

        anchors.fill: parent
        contentHeight: parent.height + units.gu(2)
        contentWidth: parent.width

        Column {
            anchors.centerIn: parent
            height: parent.height - 200
            width: parent.width - 100
            spacing: 25

            Label {
                text: qsTr("Radio name:")
            }

            TextField {
                id: names
                errorHighlight: false
                width: parent.width
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: name
            }
            Label {
                text: qsTr("Radio adress:")
            }

            TextField {
                id: ips
                errorHighlight: false
                width: parent.width
                height: units.gu(4)
                font.pixelSize: FontUtils.sizeToPixels("medium")
                text: ip
            }

            Button {
                id: save
                width: parent.width
                text: qsTr("Update station")
                onClicked: {
                    DB.update(names.text, ips.text, id)
                    save.text = qsTr("Changes has been saved")
                    settings.state = "true"
                }
            }

            Label {
                id: info
                width: parent.width
                text: ""
            }
        }
    }
}
