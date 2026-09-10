import QtQuick
import Quickshell
import "../../../services"

Text {
  text: TimeService.timeString
  color: "#cdd6f4"
  font.pixelSize: 16
  //font.fontWeight: 0
}
