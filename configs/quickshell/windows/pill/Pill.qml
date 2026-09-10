import QtQuick
import Quickshell

import "./views"

PanelWindow {
  id: window
  required property var modelData
  screen: modelData

  anchors {top: true; left: true; right: true }
  exclusiveZone: 40
  implicitHeight: statusPill.height + (statusPill.anchors.topMargin * 2)
  color: "transparent"

  PillState { id: barState; name: screen?.name ?? "" }
  Rectangle {
    id: statusPill

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 10
    color: "#1e1e2e" //TODO: dont hardcode colors!
    clip: true

    property int horizontalPadding: 0
    property int verticalPadding: 0

    width: (contentLoader.item ? contentLoader.item.implicitWidth : 300) + horizontalPadding
    height: (contentLoader.item ? contentLoader.item.implicitHeight : 300) + verticalPadding

    radius: barState.isPinned ? 16 : height / 2

    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
    Behavior on radius { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

    Loader {
      id: contentLoader
      anchors.centerIn: parent
      source: {
        barState.notification? 
        barState.views["toastView"] :
        barState.currentView
      }
      onLoaded: {
        if (item && item.hasOwnProperty("barState")) {
          item.barState = barState;
        }
      }
    }
  }
}
