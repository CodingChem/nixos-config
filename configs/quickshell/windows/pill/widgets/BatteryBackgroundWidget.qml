// components/BatteryGlowBorder.qml
import QtQuick
import "../../../services"

Rectangle {
  id: root
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  anchors.left: parent.left
  anchors.right: parent.right
  radius: parent.radius
  color: "transparent"

  Rectangle {
    id: batteryFill
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    topRightRadius: parent.radius
    topLeftRadius: PowerService.percentage > 95 ? parent.radius : 0
    bottomRightRadius: parent.radius
    bottomLeftRadius: PowerService.percentage > 95 ? parent.radius : 0

    // Only show fill if a battery exists
    visible: PowerService.hasBattery

    // Width maps to percentage (0.0 to 1.0)
    width: parent.width * (PowerService.percentage / 100)
    //radius: parent.radius

    // Accent color (Blue or Green when charging)
    color: PowerService.isCharging ? "#a6e3a1" : PowerService.isLow ? "#89b4fa" : "red"
    opacity: 0.35 // Subtle fill under the text

    Behavior on width { 
      NumberAnimation { duration: 400; easing.type: Easing.OutCubic } 
    }
  }
  Rectangle {
    id: batteryGlow
    anchors.fill: parent
    radius: parent.radius
    color: "transparent"
    border.width: 1.5

    readonly property color baseColor: PowerService.isCharging ? "#a6e3a1" : (PowerService.percentage < 25 ? "#f38ba8" : "#89b4fa")
    border.color: Qt.rgba(baseColor.r, baseColor.g, baseColor.b, 0.6)

    // Optional breathing pulse when charging
    SequentialAnimation on opacity {
      running: PowerService.isCharging
      loops: Animation.Infinite
      NumberAnimation { to: 0.3; duration: 1200; easing.type: Easing.InOutSine }
      NumberAnimation { to: 1.0; duration: 1200; easing.type: Easing.InOutSine }
    }
  }
}
