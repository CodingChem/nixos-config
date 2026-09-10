import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../../services"

Item {
    id: root
    property var barState
    readonly property string screenName: barState?.name ?? ""

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    // Icon array indexed 0-8 for workspaces 1-9 (Nerd Font or Unicode)
    readonly property var icons: [
        "", // 1: Browser
        "", // 2: Terminal
        "󰊗", // 3: Games
        "", // 4: Chat
        "", // 5: Code
        "", // 6: Music
        "󰈙", // 7: Docs
        "", // 8: Settings
        ""  // 9: Misc
    ]

    // Resolve the monitor object for this specific screen
    readonly property var currentHlMonitor: {
        for (let mon of Hyprland.monitors.values) {
            if (mon.name === root.screenName) return mon;
        }
        return null;
    }

    RowLayout {
        id: layout
        spacing: 12

        Repeater {
            // Option A: Fixed range 1-9, filtered by the monitor they currently live on
            model: 9

            Text {
                required property int index
                readonly property int wsId: index + 1

                // Locate this workspace in Hyprland's active workspaces
                readonly property var wsObj: {
                    for (let ws of Hyprland.workspaces.values) {
                        if (ws.id === wsId) return ws;
                    }
                    return null;
                }

                // Show only if the workspace belongs to this monitor (or default monitor if empty)
                readonly property bool belongsToMonitor: wsObj 
                    ? wsObj.monitor?.name === root.screenName && isActive
                    : (root.currentHlMonitor && root.currentHlMonitor.activeWorkspace?.id === wsId)

                visible: belongsToMonitor
                Layout.preferredWidth: visible ? implicitWidth : 0

                readonly property bool isActive: root.currentHlMonitor?.activeWorkspace?.id === wsId

                font.family: "JetBrainsMono Nerd Font" // Ensure your Nerd Font is installed
                font.pixelSize: 16

                text: root.icons[index] || ""
                color: isActive ? ThemeProvider.text: (wsObj ? ThemeProvider.textMuted: ThemeProvider.primary)

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Hyprland.dispatch("workspace " + wsId)
                }
            }
        }
    }
}
