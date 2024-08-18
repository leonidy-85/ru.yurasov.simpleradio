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
    property string url: ""

    Component.onCompleted: {
        DB.initializeDB()
    }


    Timer {
        id: db
        interval: 1000
        triggeredOnStart: true
        running: true
        repeat: true
        onTriggered: {
            mainapp.track= mediaPlayer.title

            if (mainapp.state_b !== true) {
                playlist.clear()
                DB.readPlaylist()
                DB.player = false
                mainapp.state_b=true
            }

            if(mainapp.play===true && mainapp.cover_st===true){
                mediaPlayer.pause()
                mainapp.cover_st = false;
            }
            if(mainapp.play===false && mainapp.cover_st===true) {
                mediaPlayer.source = DB.adr
                mediaPlayer.play()
                mainapp.cover_st = false;
            }
        }
    }

    Component {
        id: dialogComponent
        Dialog {
            DialogHeader {
                id: header
                title: qsTr("Do you want to delete the ?")
            }
        }
    }

    AppBarMenu {}

    Column {
        anchors.fill: parent
        spacing: 5
        anchors.topMargin: 140


        SilicaFlickable {
            width: parent.width
            leftMargin: Theme.horizontalPageMargin
            rightMargin: Theme.horizontalPageMargin
            anchors.topMargin: 50
            height:  1000

            SilicaListView {
                id: list
                anchors.fill: parent
                leftMargin: Theme.horizontalPageMargin
                rightMargin: Theme.horizontalPageMargin
                VerticalScrollDecorator {}

                model: ListModel {
                    id: playlist
                }
                delegate: ListItem {
                    menu: contextMenu
                    contentHeight: Theme.itemSizeSmall
                    ListView.onRemove: animateRemoval(ListItem)

                    Item {
                        anchors {
                            verticalCenter: parent.verticalCenter
                        }
                        height: Theme.itemSizeSmall
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
                    onPressAndHold: menu.active ? menu.hide() : menu.open(listItem)

                    Component {
                        id: contextMenu
                        ContextMenu {
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
                    }
                    onClicked: {
                        onClicked: DB.play(ip)
                        DB.adr = ip
                        player = true
                        mainapp.state_b=false

                    }
                }
            }
        }

        Column {
            anchors {
                margins: units.gu(2)
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            height: 150

            Separator {
                color: Theme.primaryColor
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: units.gu(2)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                width: 100

                IconButton {
                    anchors.leftMargin: 50
                    icon.source: mainapp.play === true ?
                                     "image://theme/icon-l-play?" + (pressed ? Theme.highlightColor : Theme.primaryColor) :
                                     "image://theme/icon-l-pause?" + (pressed ? Theme.highlightColor : Theme.primaryColor)

                    onClicked: {
                        if (mainapp.play === false) {
                            mediaPlayer.pause()
                            mainapp.play = true
                        } else {
                            mediaPlayer.source = DB.adr
                            mediaPlayer.play()
                            mainapp.play = false
                        }
                    }
                }

                Row {
                   width: Math.max(t1.width + spacing, 0)
                    height: Theme.fontSizeSmall + Theme.paddingLarge
                    spacing: Theme.paddingMedium
                    y: Theme.paddingLarge

                    Item {
                        id: root
                        property int spacing: 50
                        property real startX: root.width
                        width: t1.width + spacing
                        height: t1.height
                        clip: true
                        anchors.left: parent.left
                        anchors.leftMargin: 20

                        Label {
                            id: t1
                            text: mediaPlayer.errorString || mediaPlayer.title
                            NumberAnimation on x {
                                running: true
                                from: 0
                                to: -root.width
                                duration: 1000
                                //loops: Animation.Infinite
                                onRunningChanged: {
                                    if (!running) {
                                        //  t1.x = startX;
                                        duration = 20000;
                                        running = true;
                                    }
                                }
                            }
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.primaryColor

                        }
                    }


                }
            }
        }



    }


    MediaPlayer {
        id: mediaPlayer
        autoPlay: false
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


}
