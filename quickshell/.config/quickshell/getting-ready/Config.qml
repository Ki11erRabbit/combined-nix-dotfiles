pragma Singleton
// Config.qml — User configuration for the Getting Ready screen.
// Edit the values below to customize behaviour.

import Quickshell
import QtQuick

Singleton {
    id: root

    // ──────────────────────────────────────────────────────────────
    // TIME
    // How many seconds the screen stays up (ignored when videoPath
    // is set, because the video length drives the duration instead).
    // ──────────────────────────────────────────────────────────────
    readonly property int durationSeconds: 5

    // ──────────────────────────────────────────────────────────────
    // VIDEO  (overrides durationSeconds when non-empty)
    // Absolute path to a video file, e.g. "/home/user/intro.mp4"
    // Leave as "" to disable video mode.
    // Requires qt6-multimedia to be installed.
    // ──────────────────────────────────────────────────────────────
    readonly property string videoPath: ""

    // ──────────────────────────────────────────────────────────────
    // BACKGROUND  (ignored when videoPath is set)
    //   backgroundMode: "color" | "image"
    //   solidColor: any CSS/QML color string, e.g. "#1a1a2e"
    //   imagePath: absolute path to an image, e.g. "/home/user/bg.jpg"
    // ──────────────────────────────────────────────────────────────
    readonly property string backgroundMode: "color"   // "color" | "image"
    readonly property color  solidColor:     "#eff1f5"
    readonly property string imagePath:      ""

    // ──────────────────────────────────────────────────────────────
    // MESSAGES
    // One is chosen at random each time the screen appears.
    // ──────────────────────────────────────────────────────────────
    readonly property var messages: [
        "You're such a good girl Alice. Keep it up!",
        "You're such a good girl",
        "Life cold and hard, tiddies soft and warm",
        "meow meow meow meow meow",
        ":3",
        "ᗜˬᗜ",
        "how to bash cat with pipe",
    ]

    // ──────────────────────────────────────────────────────────────
    // SPINNER
    // ──────────────────────────────────────────────────────────────
    readonly property color spinnerColor: "#ea76cb"
    readonly property int   spinnerSize:  72
    readonly property int   spinnerWidth: 6

    // ──────────────────────────────────────────────────────────────
    // TYPOGRAPHY
    // ──────────────────────────────────────────────────────────────
    readonly property color textColor:       "#ea76cb"
    readonly property color subtitleColor:   "#ea76cb"
    readonly property int   titleFontSize:   28
    readonly property int   messageFontSize: 16
}
