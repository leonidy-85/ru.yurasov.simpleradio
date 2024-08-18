import QtQuick 2.2
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import Nemo.Notifications 1.0
import ru.yurasov.wallet.FileIO 1.0
import "../db.js" as DB

Page {
  id: exportPage

  allowedOrientations: Orientation.All

  property QtObject parentPage: null
  property string mode: "import"

  function fillNum(num) {
    if (num < 10) {
      return("0"+num);
    } else {
      return(num)
    }
  }



  // FileIO Object for reading / writing files
  FileIO {
    id: exportFile
    source: fileName.text
    onError: { console.log(msg); }
  }
  Notification {
      id: notification
      itemCount: 1
  }


  SilicaFlickable {
    id: exportFlickable
    anchors.fill: parent

    // FilePicker for the Input File
    Component {
      id: filePickerPage
      FilePickerPage {
        nameFilters: [ '*.json','*.m3u' ]
        onSelectedContentPropertiesChanged: {
          fileName.text = selectedContentProperties.filePath
        }
      }
    }

    VerticalScrollDecorator {}

     Column {
      spacing: 10
      anchors.fill: parent
      PageHeader {
          objectName: "pageHeader"
          title: qsTr("Load playlist")
      }

      TextField {
        id: fileName
        width: parent.width
        text:  "";
        label: qsTr("Filename")
        visible: mode !== "import"
        focus: true
        horizontalAlignment: TextInput.AlignLeft
        EnterKey.enabled: text.length > 0
        EnterKey.iconSource: "image://theme/icon-m-enter-accept"
        EnterKey.onClicked: exportPage.accept()
      }

      ValueButton {
        width: parent.width
        label: qsTr("File to import")
        value: fileName.text ? fileName.text : "None"
        visible: mode == "import"
        onClicked: pageStack.push(filePickerPage)
      }


      Text {
        id: importText

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        width: parent.width - 2*Theme.paddingLarge

        wrapMode: Text.Wrap
        maximumLineCount: 15
        font.pixelSize: Theme.fontSizeTiny
        color: Theme.secondaryColor

        visible: mode == "import"
        text: qsTr("Here you can download playlist from file. Enter file location. Click download button to start downloading.")
      }

//      Text {
//        id: exportText

//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.bottomMargin: 20
//        width: parent.width - 2*Theme.paddingLarge

//        wrapMode: Text.Wrap
//        maximumLineCount: 15
//        font.pixelSize: Theme.fontSizeTiny
//        color: Theme.secondaryColor

//        visible: mode == "export"
//        text: qsTr("Here you can export barcode from a file")
//      }
      Separator {
          color: Theme.primaryColor
          width: parent.width
          anchors.horizontalCenter: parent.horizontalCenter
          horizontalAlignment: Qt.AlignHCenter
      }
      Button {
          id: save
          width: parent.width * 0.8
          anchors.horizontalCenter: parent.horizontalCenter
          visible: fileName.text.length > 0 && (mode == "import" ) || checkFileName(fileName.text) ? true : false
          text: qsTr("Load")
          onClicked: {
              onDone()
           }
        }
     }
  }
  // Do the DB-Export / Import
  function onDone() {
      var plainText = ""
        // load playlist from File
        plainText = exportFile.read();
        if (plainText != "") {
             var errormsg = ""
            if (DB.json2db(plainText, errormsg)) {
                   DB.banner('OK', qsTr("Playlist database load from ")+ fileName.text)
                    mainapp.state_b=false
                 pageStack.pop();
            } else {
              DB.banner(errormsg);
            }
        } else {
            DB.banner('Error', qsTr("Could not read from file ")+ fileName.text)
         }
      }


  }



