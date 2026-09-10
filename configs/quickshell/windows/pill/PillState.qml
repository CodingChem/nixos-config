import Quickshell
import QtQuick
import "../../services"

QtObject {
  id: barState
  required property string name
  property var notification: null
  property real notificationExpiry: 0
  // states
  property var views: {
    "restingView": "./views/RestingView.qml",
    "toastView": "./views/ToastView.qml",
  }
  property string currentView: views["restingView"]

  property bool isPinned: false
  property var notificationListner: Connections {
    target: NotificationService

    function onNewNotification(notif) {
      if (NotificationService.doNotDisturb) return;
      if (barState.currentMode === barState.modeLauncher) return;
      if (notif === null) {

      }

      notification = notif
    }
  }
}
