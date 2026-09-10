import QtQuick
import Quickshell
import "./windows/pill"

ShellRoot {
  id: root
  Variants {
    model: Quickshell.screens
    delegate: Component {
      Pill {
        screen: modelData
      }
    }
  }
}
