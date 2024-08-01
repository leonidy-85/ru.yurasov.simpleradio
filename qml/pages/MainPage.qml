import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.6
import Amber.Mpris 1.0
import "../components"
import "../db.js" as DB

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.Portrait

    property bool player: false
    property int number: 0

    Component.onCompleted: {
        DB.initializeDB()
    }

    SilicaFlickable {
        anchors.fill: parent

        AppBarMenu {}

        Component {
            id: dialogComponent
            Dialog {
                DialogHeader {
                    id: header
                    title: qsTr("Do you want to delete the ?")
                }
            }
        }
        Timer {
            id: db
            interval: 5000
            triggeredOnStart: true
            running: true
            repeat: true
            onTriggered: {
                if (DB.state_b != true) {
                    playlist.clear()
                    DB.readPlaylist()
                    DB.player = false
                }
            }
        }
        ListModel {
            id: playlist
            Component.onCompleted: DB.readPlaylist()
        }
        Column {
            anchors.centerIn: parent
            width: parent.width - 100
            spacing: 50

            Row {
                width: parent.width
                height: 800

                ListView {
                    model: playlist
                    id: listing
                    anchors.fill: parent

                    delegate: ListItem {
                        width: ListView.view.width
                        contentHeight: Theme.itemSizeSmall

                        MenuItem {
                            Label {
                                id: id_list
                                text: id
                                anchors.leftMargin: Theme.paddingMedium
                                font.pixelSize: Theme.fontSizeMedium
                                color: (highlighted || DB.adr === ip) ? Theme.highlightColor : Theme.primaryColor
                            }
                            Label {
                                id: name_list
                                text: name
                                anchors.left: id_list.right
                                anchors.leftMargin: Theme.paddingMedium
                                font.pixelSize: Theme.fontSizeMedium
                                color: (highlighted || DB.adr === ip) ? Theme.highlightColor : Theme.primaryColor
                            }

                        }

                        menu: ContextMenu {
                            MenuItem {
                                text: qsTr("Edit")
                                onClicked: pageStack.push(Qt.resolvedUrl(
                                                              "PageEdit.qml"), {
                                                              "id": id,
                                                              "name": name,
                                                              "ip": ip
                                                          })
                            }
                            MenuItem {
                                text: qsTr("Delete")
                                // onClicked: DB.del(ip)
                                onClicked: {
                                    var dialog = pageStack.push(
                                                dialogComponent, name)
                                    dialog.accepted.connect(function () {
                                        onClicked: DB.del(id)
                                    })
                                }
                            }
                        }
                        onClicked: {
                            onClicked: DB.play(ip)
                            DB.adr = ip//???
                             player = true
                            play_b.text = qsTr("Pause")
                        }
                    }
                }
            }

            MediaPlayer {
                id: mediaPlayer
                autoPlay: true
                source: url
                property string title: !!metaData.author
                                       && !!metaData.title ? qsTr(
                                                                 "%1 - %2").arg(
                                                                 metaData.author).arg(
                                                                 metaData.title) : metaData.author
                                                             || metaData.title
                                                             || metaData.audioBitRate
                                                             || metaData.AudioCodec
                                                             || source
            }

            MprisPlayer {
                id: mprisPlayer
                serviceName: "sradio"
                identity: mediaPlayer.title
                supportedUriSchemes: ["file"]
                canControl: true

                canGoNext: false
                canGoPrevious: false
                canPause: true
                canPlay: true
                canSeek: false


                playbackStatus: player ? Mpris.Playing : Mpris.Paused

                onPlayPauseRequested: {
                    if (player) {
                        mediaPlayer.pause()
                        player = false
                    } else {
                        mediaPlayer.play()
                        player = true
                    }
                }
            }

            Row {
                width: parent.width
                height: 50
                Label {
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Theme.paddingLarge
                    }
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    // truncationMode: Elide
                    wrapMode: Text.Wrap
                    text: mediaPlayer.errorString || mediaPlayer.title
                }
                Separator {
                    color: Theme.highlightColor
                    width: parent.width
                }

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: mediaPlayer.audioBitRate
                }

                Label {
                    anchors.centerIn: parent
                    font.pixelSize: Theme.fontSizeLarge
                    color: Theme.primaryColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: mediaPlayer.AudioCodec
                }
            }
        }
        Column {
            id: col2
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            Row {
                spacing: units.gu(2)
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    id: play_b
                    color: "#068706"
                    width: units.gu(14)
                    text:  qsTr("Play")
                    onClicked: {
                        //  describe.text = dbprimary.get(channel).descripcion
                        if (player === false) {
                            play_b.text = qsTr("Play")
                            mediaPlayer.source = DB.adr
                            mediaPlayer.pause()
                            player = true
                        } else {

                            play_b.text = qsTr("Pause")
                            mediaPlayer.play()
                            player = false
                        }
                    }
                }
            }
        }
    }


}
