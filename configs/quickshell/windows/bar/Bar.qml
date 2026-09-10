import QtQuick
import Quickshell
import QtQuick.Layouts
import "../../services"

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: win
        required property var modelData

        screen: modelData

        anchors {
            left: true
            top: true
            right: true
        }
        implicitHeight: 38
        color: ThemeProvider.surface

        Item {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            anchors.topMargin: 4
            anchors.bottomMargin: 4

            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                Workspaces {
                    screenName: win.screen.name
                }
            }

            RowLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                Clock { }
            }

            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                Battery { }
            }
        }
    }
}
