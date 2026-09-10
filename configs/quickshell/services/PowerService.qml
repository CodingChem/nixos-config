pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root
    readonly property var battery: UPower.displayDevice
    // 2. Safe check against null
    readonly property bool hasBattery: battery != null && battery.isPresent
    
    readonly property real percentage: battery ? battery.percentage * 100 : 0
    
    readonly property bool isCharging: battery ? (battery.state === UPowerDeviceState.Charging) : false

    readonly property bool isLow: battery ? (battery.percentage < 25) : false 
}
