pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root

  property string timeString: Qt.formatTime(clock.date, "hh:mm")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
  }
