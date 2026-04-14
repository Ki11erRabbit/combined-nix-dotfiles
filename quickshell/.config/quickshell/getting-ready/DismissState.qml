pragma Singleton
// DismissState.qml
// Shared singleton so that dismissing on any one screen
// (key press, click, timer, video end) dismisses all screens.

import Quickshell

Singleton {
    // Flipped to true by whichever screen instance triggers dismiss.
    // All GettingReadyScreen instances watch this and fade out together.
    property bool dismissed: false
}
