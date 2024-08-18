import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.6
import "../pages"
import "../db.js" as DB

CoverBackground {
    objectName: "defaultCover"

    CoverPlaceholder {
        objectName: "placeholder"
        text:  mainapp.track
        icon {
            source: Qt.resolvedUrl("../icons/radio.png")
            sourceSize {
                width: 128
                height: 128
            }
        }
        forceFit: true
    }


    CoverActionList {
        id: coverAction

        CoverAction {
            id: coverActionPlay
            iconSource: mainapp.play === true?"image://theme/icon-cover-play":"image://theme/icon-cover-pause"
            onTriggered: {
                if (mainapp.play === true &&  mainapp.cover_st === false) {
                    mainapp.play = false;
                    mainapp.cover_st = true;
                }
                if (mainapp.play === false &&  mainapp.cover_st === false ) {
                    mainapp.play= true;
                    mainapp.cover_st = true;
                }
            }
        }
    }

}
