import QtQuick
import Quickshell
import "../../services"

Text {
    id: root

    text: TimeService.timeString
    color: ThemeProvider.text
}
