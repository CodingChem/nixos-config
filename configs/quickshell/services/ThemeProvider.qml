pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    // File watcher on the symlink
    property FileView file: FileView {
        path: Quickshell.configPath("current_theme.json")
        watchChanges: true
        blockLoading: true // Ensure initial load is available on startup

        onFileChanged: {
            this.reload();
        }
    }

    // Parsed JSON object cache
    readonly property var colors: {
        try {
            const raw = root.file.text();
            return raw ? JSON.parse(raw) : {};
        } catch (e) {
            console.warn("Theme JSON parse error:", e);
            return {};
        }
    }

    // Dynamic color properties with sensible fallbacks
    readonly property color background: colors.background || "#181825"
    readonly property color surface:    colors.surface    || "#1e1e2e"
    readonly property color text:       colors.text       || "#cdd6f4"
    readonly property color textMuted:  colors.textMuted  || "#6c7086"
    readonly property color primary:    colors.primary    || "#cba6f7"
    readonly property color urgent:     colors.urgent     || "#f38ba8"

    // Typography & Metrics
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 13
}
