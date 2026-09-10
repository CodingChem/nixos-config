import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property var barState: null
    readonly property var notif: barState?.notification

    implicitHeight: 32
    implicitWidth: layout.implicitWidth + 24

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 10

        // App Icon (reads appIcon or image directly from notification)
        Image {
            visible: (root.notif?.appIcon ?? "").length > 0
            source: root.notif?.appIcon ?? ""
            Layout.preferredWidth: 16
            Layout.preferredHeight: 16
            fillMode: Image.PreserveAspectFit
        }

        // Summary
        Text {
            text: root.notif?.summary ?? ""
            color: "#cdd6f4"
            font.pixelSize: 12
            font.bold: true
            elide: Text.ElideRight
            Layout.maximumWidth: 180
        }

        // Actions directly invoked from the native object
        Repeater {
            model: root.notif ? root.notif.actions : 0

            Rectangle {
                required property var modelData // NotificationAction

                implicitWidth: actionLabel.implicitWidth + 12
                implicitHeight: 20
                radius: 4
                color: "#45475a"

                Text {
                    id: actionLabel
                    anchors.centerIn: parent
                    text: modelData.text
                    font.pixelSize: 10
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        modelData.invoke();
                        root.barState.dismissToast();
                    }
                }
            }
        }
    }

    // Dismiss on clicking toast background
    MouseArea {
        anchors.fill: parent
        z: -1
        cursorShape: Qt.PointingHandCursor
        onClicked: root.barState.dismissToast()
    }
}
