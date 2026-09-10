import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../services"

Item {
    id: root

    // Automatically hide the widget on desktops or when no battery exists
    implicitWidth: PowerService.hasBattery ? layout.implicitWidth : 0
    implicitHeight: PowerService.hasBattery ? layout.implicitHeight : 0

    readonly property string icon: {
        if (PowerService.isCharging) return "󰂄";
        if (PowerService.percentage >= 90) return "󰁹";
        if (PowerService.percentage >= 80) return "󰂂";
        if (PowerService.percentage >= 70) return "󰂁";
        if (PowerService.percentage >= 60) return "󰂀";
        if (PowerService.percentage >= 50) return "󰁿";
        if (PowerService.percentage >= 40) return "󰁾";
        if (PowerService.percentage >= 30) return "󰁽";
        if (PowerService.percentage >= 20) return "󰁼";
        if (PowerService.percentage >= 10) return "󰁻";
        return "󰂃";
    }

    RowLayout {
        id: layout
        spacing: 6
        anchors.verticalCenter: parent.verticalCenter

        Text {
            text: root.icon
            font.family: ThemeProvider.fontFamily
            font.pixelSize: 16
            color: PowerService.isLow ? ThemeProvider.urgent : (PowerService.isCharging ? ThemeProvider.primary : ThemeProvider.text)
        }

        Text {
            text: PowerService.percentage + "%"
            font.family: ThemeProvider.fontFamily
            font.pixelSize: ThemeProvider.fontSize
            color: PowerService.isLow ? ThemeProvider.urgent : ThemeProvider.text
        }
    }
}
