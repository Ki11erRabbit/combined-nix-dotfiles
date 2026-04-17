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
        "This text is black. If you see pink, you're actually a cute trans girl :3",
        "女の子になりたい",
        "Life cold and hard, tiddies soft and warm",
        "meow meow meow meow meow",
        ":3",
        "ᗜˬᗜ",
        "how to bash cat with pipe",
        "Don't forget food and water :)",
        "UwU",
        "Do you think God stays in heaven because he, too, lives in fear of what he's created here on earth?",
        "Chat? Is this real?",
        "People die if they are killed.",
        "The Archer class really is made up of archers!",
        "When you have a birthday, you celebrate being born.",
        "shikanoko nokonoko koshitantan",
        "お前はもう死んでいる",
        "If I can do it tomorrow, I'll do it today!",
        "Remember to kiss the homies goodnight",
        "Needs more cowbell",
        "mi casa su casa",
        "SUBLIME",
        "Don't cry over spilled milk",
        "Don't throw out the baby with the bath water",
        "Be gay do crime",
        "Check your posture",
        "We're all mad here",
        "Don't forget to stand up and stretch once in a while!",
        "Got any grapes?",
        "awww the scrunkly 🥰🥺🥺🥺🥺🥺🥺🥺🥺🥺🥺🥺 double tap now if you'd scrunkly the when😆",
        "ʕ.•⁠ᴥ-.ʔ~♪",
        "Crazy? I was crazy once. They put me in a room. A rubber room. A rubber room with rats.\nThey put me in a rubber room with rubber rats. Rubber rats? I hate rubber rats. They make me crazy.",
        "La vida es dura, pero más dura es mi verdura B)",
        "Pump it up kitty",
        "When you try to save a damsel in distress, all you get is a distressed damsel",
        "Don't be mean; we don't have to be mean, cuz, remember, no matter where you go, there you are",
        "shine bright",
        "Gentlemen, you can't fight in here! This is the War Room!",
        "The atonement of Jesus Christ brings clarity into our lives no matter how many other concerns we have",
        "Sometimes, we need faith in Jesus Christ that all will work out in the end",
        "See each other as children of God who belong to each other",
        "No one of us alone can change the world, but each of us can have an influence on the world",
        "WHY IS THERE CODE??? MAKE AN .EXE FILE AND GIVE IT TO ME. Stupid smelly nerds",
        "Cat ears are quantum mechanics",
        "△×￥○＠％＆＄＃☆□！",
        "to obtain or create something, an item or action of equal value must be given or sacrificed",
        "私は眠らない明日",
        "I am the sleepless tomorrow",
        "Don't forget.\nAlways, somewhere,\nsomeone is fighting for you. As long as you remember her,\nyou are not alone."
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

    // ──────────────────────────────────────────────────────────────
    // PRIMARY SCREEN
    // The screen that shows the full getting-ready UI (spinner,
    // message, progress bar, input capture).
    // All other screens show only the background color.
    //
    // Leave as "" to automatically use the first screen in
    // Quickshell.screens (usually your main monitor).
    //
    // Set to a screen name to pin to a specific monitor, e.g.:
    //   readonly property string primaryScreenName: "DP-1"
    // You can find screen names by running: quickshell --list-screens
    // ──────────────────────────────────────────────────────────────
    readonly property string primaryScreenName: ""
}
