// SpinnerArc.qml
// A continuously rotating arc spinner drawn with Canvas.

import QtQuick

Item {
    id: root

    property int   size:        64
    property int   strokeWidth: 5
    property color arcColor:    "#7f5af0"

    width:  size
    height: size

    NumberAnimation on rotation {
        from:     0
        to:       360
        duration: 900
        loops:    Animation.Infinite
        running:  true
        easing.type: Easing.Linear
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            var cx         = width  / 2
            var cy         = height / 2
            var r          = (Math.min(width, height) - root.strokeWidth) / 2
            var startAngle = -Math.PI / 2
            var endAngle   = startAngle + Math.PI * 1.5   // 270° arc

            ctx.beginPath()
            ctx.arc(cx, cy, r, startAngle, endAngle, false)
            ctx.strokeStyle = root.arcColor.toString()
            ctx.lineWidth   = root.strokeWidth
            ctx.lineCap     = "round"
            ctx.stroke()
        }

        Connections {
            target: root
            function onArcColorChanged() { canvas.requestPaint() }
        }

        Component.onCompleted: requestPaint()
    }
}
