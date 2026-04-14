// shell.qml — Quickshell entry point
import Quickshell
import QtQuick

ShellRoot {
    // Spawn one window per connected screen.
    // Each instance receives its screen via modelData and knows
    // whether it is the "primary" screen (the one that shows the
    // full getting-ready UI). All other screens show only the
    // solid background color.
    Variants {
        model: Quickshell.screens

        delegate: Component {
            GettingReadyScreen {
                property var modelData

                screen: modelData

                // "Primary" = the screen whose name matches
                // Config.primaryScreenName, or — if that is empty —
                // the first screen in the list (index 0).
                isPrimary: Config.primaryScreenName !== ""
                    ? modelData.name === Config.primaryScreenName
                    : modelData === Quickshell.screens[0]
            }
        }
    }
}
