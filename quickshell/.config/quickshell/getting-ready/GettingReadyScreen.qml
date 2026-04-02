// GettingReadyScreen.qml
// Full-screen "Getting Ready" overlay.
//
// Key fixes vs the previous version:
//   • WlrLayershell attached properties are set in Component.onCompleted so
//     they only run on Wayland and never crash on X11 or when the import
//     isn't available at parse time.
//   • PanelWindow.focusable: true is used (the platform-agnostic way to
//     request keyboard focus).
//   • Video and background are loaded via Loader + inline Components so
//     QtMultimedia is only touched when the user actually sets videoPath.

import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root

    // ── Full-screen anchors ──────────────────────────────────────────
    anchors.top:    true
    anchors.bottom: true
    anchors.left:   true
    anchors.right:  true

    // Request keyboard focus (platform-agnostic PanelWindow property)
    focusable: true

    // No exclusion zone — we're an overlay, not a panel
    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    // Apply WlrLayershell-specific settings safely at runtime,
    // and imperatively pick the random message so Math.random()
    // actually runs instead of being treated as a static binding.
    Component.onCompleted: {
        if (WlrLayershell !== null) {
            WlrLayershell.layer         = WlrLayer.Overlay
            WlrLayershell.keyboardFocus = WlrKeyboardFocus.Exclusive
        }
        var msgs = Config.messages
        chosenMessage = msgs[Math.floor(Math.random() * msgs.length)]
    }

    // ── State ────────────────────────────────────────────────────────
    property bool   dismissed:     false
    property string chosenMessage: ""   // set imperatively in onCompleted

    // ── Dismiss ──────────────────────────────────────────────────────
    function dismiss() {
        if (!dismissed) {
            dismissed = true
            fadeOut.start()
        }
    }

    // ── Overlay item (the thing we fade) ────────────────────────────
    Item {
        id: overlay
        anchors.fill: parent
        opacity:      0          // starts transparent; entrance anim below

        // Entrance fade-in
        NumberAnimation on opacity {
            from:     0.0
            to:       1.0
            duration: 600
            easing.type: Easing.OutQuad
        }

        // ── Keyboard: any key dismisses ──────────────────────────────
        focus: true
        Keys.onPressed: (event) => {
            event.accepted = true
            root.dismiss()
        }

        // ── Mouse: any click or scroll dismisses ─────────────────────
        MouseArea {
            anchors.fill:    parent
            acceptedButtons: Qt.AllButtons
            onPressed:       root.dismiss()
            onWheel:         root.dismiss()
        }

        // ── Background ───────────────────────────────────────────────
        Loader {
            id: bgLoader
            anchors.fill: parent
            sourceComponent:
                Config.videoPath !== ""               ? videoBackground  :
                Config.backgroundMode === "image"     ? imageBackground  :
                                                        colorBackground
        }

        Component {
            id: colorBackground
            Rectangle {
                anchors.fill: parent
                color:        Config.solidColor
            }
        }

        Component {
            id: imageBackground
            Image {
                anchors.fill: parent
                source:       Config.imagePath
                fillMode:     Image.PreserveAspectCrop
            }
        }

        // Video background — QtMultimedia is only referenced inside
        // this Component, so it won't error if you haven't set videoPath.
        Component {
            id: videoBackground
            VideoBackground {
                anchors.fill: parent
                onVideoEnded: root.dismiss()
            }
        }

        // Dark scrim so text is readable on image/video backgrounds
        Rectangle {
            anchors.fill: parent
            color:   "#000000"
            opacity: Config.videoPath !== ""          ? 0.35 :
                     Config.backgroundMode === "image"? 0.45 : 0.0
        }

        // ── Centre content ───────────────────────────────────────────
        Column {
            anchors.centerIn: parent
            spacing: 28

            SpinnerArc {
                anchors.horizontalCenter: parent.horizontalCenter
                size:        Config.spinnerSize
                strokeWidth: Config.spinnerWidth
                arcColor:    Config.spinnerColor
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  "Getting Ready"
                color: Config.textColor
                font {
                    pixelSize:     Config.titleFontSize
                    weight:        Font.DemiBold
                    family:        "monospace"
                    letterSpacing: 3
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  root.chosenMessage
                color: Config.subtitleColor
                font {
                    pixelSize:     Config.messageFontSize
                    family:        "monospace"
                    letterSpacing: 1
                }
            }

            // Progress bar — only shown in timed (non-video) mode
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: Config.videoPath === ""
                width:  220
                height: 3

                Rectangle {
                    anchors.fill: parent
                    color:  Qt.rgba(1, 1, 1, 0.12)
                    radius: 2
                }

                Rectangle {
                    anchors {
                        left:   parent.left
                        top:    parent.top
                        bottom: parent.bottom
                    }
                    width:  0
                    radius: 2
                    color:  Config.spinnerColor

                    NumberAnimation on width {
                        from:     0
                        to:       220
                        duration: Config.durationSeconds * 1000
                        running:  Config.videoPath === "" && !root.dismissed
                        easing.type: Easing.Linear
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  "Press any key or click to continue"
                color: Qt.rgba(
                    Config.subtitleColor.r,
                    Config.subtitleColor.g,
                    Config.subtitleColor.b,
                    0.5)
                font {
                    pixelSize:     12
                    family:        "monospace"
                    letterSpacing: 1
                }
            }
        }

        // ── Fade-out ─────────────────────────────────────────────────
        NumberAnimation {
            id: fadeOut
            target:   overlay
            property: "opacity"
            from:     1.0
            to:       0.0
            duration: 400
            easing.type: Easing.InQuad
            onFinished:  root.visible = false
        }

        // ── Auto-dismiss timer (timed mode only) ─────────────────────
        Timer {
            interval: Config.durationSeconds * 1000
            running:  Config.videoPath === ""
            repeat:   false
            onTriggered: root.dismiss()
        }
    }
}
