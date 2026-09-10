pragma Singleton
import QtQuick
import Quickshell

Singleton {
  id: root
  // 0 -> pill bar | 1 -> expanded pill bar
  property int currentMode: 0
  property string activeMonitor: ""
}
