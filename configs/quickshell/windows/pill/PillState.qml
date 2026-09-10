import Quickshell
import QtQuick

QtObject {
  id: barState
  required property string name
  // states
  readonly property int modeResting: 0
  readonly property int modeExpanded: 1
  readonly property int modeLauncher: 2
  readonly property int modeCommand: 3

  property int currentMode: modeResting

  property bool isPinned: false
}
