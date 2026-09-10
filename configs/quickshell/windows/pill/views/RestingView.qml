import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import "../../../services"
import "../widgets"

Item {
    id: root

    property var barState: null

    implicitHeight: 32
    implicitWidth: contentRow.implicitWidth + 28

    // 1. Base Pill Background (Dark Gray)
    Rectangle {
        id: bg
        anchors.fill: parent
        radius: height / 2
        color: "#313244" // Catppuccin surface0 / dark gray

        BatteryBackgroundWidget { }
    }

    // 3. Status Items Row
    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 12

        // Current Workspace
        WorkspaceWidget { barState: root.barState }

        // Separator
        Rectangle {
            width: 1
            height: 10
            color: "#585b70"
        }

        // Clock
        ClockWidget { }

        // Separator
        Rectangle {
            width: 1
            height: 10
            color: "#000000"
        }

        // Wifi Signal Indicator (Fallback icon or dynamic service)
        WifiWidget { }
    }
}
