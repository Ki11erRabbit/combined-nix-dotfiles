// VideoBackground.qml
// Isolated component for video playback.
// Keeping QtMultimedia in its own file means the import only matters
// when the user actually enables video mode (videoPath ≠ "").

import QtQuick
import QtMultimedia

Item {
    id: root

    // Emitted when the video finishes playing
    signal videoEnded

    MediaPlayer {
        id: player
        source:      Config.videoPath
        videoOutput: videoOut
        audioOutput: AudioOutput {}

        Component.onCompleted: play()

        onPlaybackStateChanged: {
            if (playbackState === MediaPlayer.StoppedState) {
                root.videoEnded()
            }
        }
    }

    VideoOutput {
        id:           videoOut
        anchors.fill: parent
    }
}
