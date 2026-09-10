pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications


Singleton {
    id: root
    property bool doNotDisturb: false
    signal newNotification(var notif)
    NotificationServer {
      id: server
      onNotification: notification => {
        notification.tracked = true
        root.newNotification(notification)
      }
    }
    function toggleDoNotDisturb() {
      doNotDisturb = !doNotDisturb
    }
    function notifications() {
      return server.trackedNotifications
    }
    function startExpiryTimer() {
    }
    function stopExpiryTimer() {
    }
    function dissmissActive() {
      root.newNotification(null)
    }
    // function Reply(string msg) {
    //   server.sendInlineReply(msg)
    // }
    // function dismiss() {
    //   server.dismiss()
    //   activeTitle = ""
    //   activeBody = ""
    //   hasActiveNotification = false
    // }
  }
