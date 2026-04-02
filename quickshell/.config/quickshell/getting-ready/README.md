# Getting Ready — Quickshell Config

A full-screen "Getting Ready" overlay for Quickshell with a spinner,
random messages, configurable background/video, and input-to-dismiss.

## Files

| File | Purpose |
|---|---|
| `shell.qml` | Quickshell entry point |
| `Config.qml` | **Everything you configure lives here** |
| `GettingReadyScreen.qml` | Main overlay (PanelWindow) |
| `SpinnerArc.qml` | Rotating arc spinner via Canvas |
| `VideoBackground.qml` | Isolated video player (QtMultimedia) |

No `qmldir` needed — Quickshell auto-discovers `.qml` files in the same
directory, and the `//@ pragma Singleton` comment at the top of `Config.qml`
registers it as a singleton accessible by filename.

## Installation

```bash
cp -r getting-ready/ ~/.config/quickshell/
quickshell -c ~/.config/quickshell/getting-ready
```

## Configuration (`Config.qml`)

### ⏱ Duration (timed mode)
```qml
readonly property int durationSeconds: 10
```

### 🎬 Video (overrides duration)
```qml
readonly property string videoPath: "/home/user/intro.mp4"
```
- Any format Qt Multimedia supports works (mp4, webm, mkv…).
- Screen auto-dismisses when the video ends.
- Leave as `""` to disable.
- Requires `qt6-multimedia` to be installed.

### 🖼 Background (used when no video)
```qml
readonly property string backgroundMode: "color"   // or "image"
readonly property color  solidColor:     "#0f0f1a"
readonly property string imagePath:      "/home/user/wallpaper.jpg"
```

### 💬 Messages
```qml
readonly property var messages: [
    "Assembling the pieces…",
    // add as many as you like
]
```

### 🌀 Spinner
```qml
readonly property color spinnerColor: "#7f5af0"
readonly property int   spinnerSize:  72    // diameter in px
readonly property int   spinnerWidth: 6     // stroke width in px
```

### 🔤 Typography
```qml
readonly property color textColor:       "#e2e8f0"
readonly property color subtitleColor:   "#94a3b8"
readonly property int   titleFontSize:   28
readonly property int   messageFontSize: 16
```

## Dismissing

Any of the following immediately ends the screen:
- Any key press
- Any mouse click (left, right, or middle button)
- Scroll wheel
- Timer expiry (timed mode) or video end (video mode)

## Dependencies

| Dependency | Required for |
|---|---|
| Quickshell | Everything |
| Qt 6 (QtQuick) | Always |
| qt6-multimedia | Video mode only |
