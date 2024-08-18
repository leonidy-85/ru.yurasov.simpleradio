import QtQuick 2.0
import Sailfish.Silica 1.0
import Aurora.Controls 1.0


    AppBar {
        id: topAppBar
        headerText: qsTr("SimpleRadio")
        headerClickable: false
        visible: opacity > 0
        Behavior on opacity { FadeAnimation {} }


               AppBarSpacer {}

                AppBarButton {
                  id: appBarMenuButton
                  icon.source: "image://theme/icon-m-menu"
                  onClicked: mainPopup.open()

                  PopupMenu {
                      id: mainPopup
                      PopupMenuItem {
                          text: qsTr("About")
                          onClicked: pageStack.push(Qt.resolvedUrl("../pages/AboutPage.qml"))
                      }
                      PopupMenuItem {
                          text: qsTr("Import stations")
                          onClicked: pageStack.push(Qt.resolvedUrl("../pages/ImportPage.qml"))
                      }

                      PopupMenuItem {
                          text: qsTr("Add")
                          onClicked: pageStack.push(Qt.resolvedUrl("../pages/AddPage.qml"))
                      }
                  }

              }
                AppBarSpacer {
                fixedWidth : 25
                }

          }


