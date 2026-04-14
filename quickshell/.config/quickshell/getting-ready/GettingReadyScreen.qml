// GettingReadyScreen.qml
// Full-screen "Getting Ready" overlay.
//
// On the primary screen: spinner, message, progress bar, input capture.
// On secondary screens:  background color/image only, dismissed in sync
//                        when the primary screen dismisses.

import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root

    // Set by shell.qml via Variants
    property bool isPrimary: true

    // ── Full-screen anchors ──────────────────────────────────────────
    anchors.top:    true
    anchors.bottom: true
    anchors.left:   true
    anchors.right:  true

    // Only the primary screen steals keyboard focus
    focusable: isPrimary

    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    Component.onCompleted: {
        if (WlrLayershell !== null) {
            WlrLayershell.layer = WlrLayer.Overlay
            if (isPrimary)
                WlrLayershell.keyboardFocus = WlrKeyboardFocus.Exclusive
            else
                WlrLayershell.keyboardFocus = WlrKeyboardFocus.None
        }
        if (isPrimary) {
            var msgs = Config.messages
            chosenMessage = msgs[Math.floor(Math.random() * msgs.length)]
        }
    }

    // ── Shared dismiss state via singleton ───────────────────────────
    // DismissState is a tiny singleton that lets all screen instances
    // observe and trigger a shared dismissed flag.

    property bool dismissed: DismissState.dismissed

    // Watch for dismiss from any screen and fade out
    onDismissedChanged: {
        if (dismissed) fadeOut.start()
    }

    function dismiss() {
        DismissState.dismissed = true
    }

    // ── Only primary needs a random message ─────────────────────────
    property string chosenMessage: ""

    // ── Overlay ──────────────────────────────────────────────────────
    Item {
        id: overlay
        anchors.fill: parent
        opacity: 0

        NumberAnimation on opacity {
            from: 0.0; to: 1.0; duration: 600
            easing.type: Easing.OutQuad
        }

        // Keyboard + mouse capture — primary screen only
        focus: isPrimary
        Keys.enabled: isPrimary
        Keys.onPressed: (event) => { event.accepted = true; root.dismiss() }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            enabled: isPrimary
            onPressed: root.dismiss()
            onWheel:  root.dismiss()
        }

        // ── Background ───────────────────────────────────────────────
        Loader {
            anchors.fill: parent
            sourceComponent:
                Config.videoPath !== ""            ? (isPrimary ? videoBackground : colorBackground) :
                Config.backgroundMode === "image"  ? imageBackground :
                                                     colorBackground
        }

        Component {
            id: colorBackground
            Rectangle { anchors.fill: parent; color: Config.solidColor }
        }

        Component {
            id: imageBackground
            Image {
                anchors.fill: parent
                source:   Config.imagePath
                fillMode: Image.PreserveAspectCrop
            }
        }

        Component {
            id: videoBackground
            VideoBackground {
                anchors.fill: parent
                onVideoEnded: root.dismiss()
            }
        }

        // Scrim
        Rectangle {
            anchors.fill: parent
            color:   "#000000"
            opacity: isPrimary && Config.videoPath !== ""           ? 0.35 :
                     isPrimary && Config.backgroundMode === "image" ? 0.45 : 0.0
        }

        // ── Primary-only content ─────────────────────────────────────
        Column {
            anchors.centerIn: parent
            spacing: 28
            visible: isPrimary

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

            // Progress bar (timed mode only)
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                visible: Config.videoPath === ""
                width: 220; height: 3

                Rectangle {
                    anchors.fill: parent
                    color: Qt.rgba(1, 1, 1, 0.12); radius: 2
                }
                Rectangle {
                    anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                    width: 0; radius: 2; color: Config.spinnerColor
                    NumberAnimation on width {
                        from: 0; to: 220
                        duration: Config.durationSeconds * 1000
                        running:  Config.videoPath === "" && !DismissState.dismissed
                        easing.type: Easing.Linear
                    }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text:  "Press any key or click to continue"
                color: Qt.rgba(Config.subtitleColor.r, Config.subtitleColor.g,
                               Config.subtitleColor.b, 0.5)
                font { pixelSize: 12; family: "monospace"; letterSpacing: 1 }
            }
        }

        // ── Fade-out ─────────────────────────────────────────────────
        NumberAnimation {
            id: fadeOut
            target: overlay; property: "opacity"
            from: 1.0; to: 0.0; duration: 400
            easing.type: Easing.InQuad
            onFinished: root.visible = false
        }

        // ── Auto-dismiss timer (primary, timed mode) ─────────────────
        Timer {
            interval: Config.durationSeconds * 1000
            running:  isPrimary && Config.videoPath === ""
            repeat:   false
            onTriggered: root.dismiss()
        }
    }
}
