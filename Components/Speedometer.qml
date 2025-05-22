// // Speedometer.qml
// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Canvas 1.15

// Item {
//     id: speedometer
//     width: 300
//     height: 300

//     property real maxSpeed: 240
//     property real currentSpeed: 0

//     Rectangle {
//         anchors.fill: parent
//         color: "#121212"
//         radius: width / 2
//         opacity: 0.95
//     }

//     Canvas {
//         id: dial
//         anchors.fill: parent
//         onPaint: {
//             var ctx = getContext("2d")
//             ctx.clearRect(0, 0, width, height)

//             var centerX = width / 2
//             var centerY = height / 2
//             var radius = width / 2.2

//             // Draw background arc
//             ctx.beginPath()
//             ctx.lineWidth = 15
//             ctx.strokeStyle = "rgba(100, 100, 100, 0.4)"
//             ctx.arc(centerX, centerY, radius, Math.PI, 2 * Math.PI)
//             ctx.stroke()

//             // Ticks
//             ctx.lineWidth = 2
//             ctx.strokeStyle = "white"
//             let steps = 12
//             for (var i = 0; i <= steps; i++) {
//                 let angle = Math.PI + (i / steps) * Math.PI
//                 let x1 = centerX + Math.cos(angle) * (radius - 10)
//                 let y1 = centerY + Math.sin(angle) * (radius - 10)
//                 let x2 = centerX + Math.cos(angle) * (radius + 10)
//                 let y2 = centerY + Math.sin(angle) * (radius + 10)
//                 ctx.beginPath()
//                 ctx.moveTo(x1, y1)
//                 ctx.lineTo(x2, y2)
//                 ctx.stroke()
//             }
//         }

//         onWidthChanged: dial.requestPaint()
//         onHeightChanged: dial.requestPaint()
//         Component.onCompleted: dial.requestPaint()
//     }

//     Rectangle {
//         id: needle
//         width: 4
//         height: 110
//         color: "#ff3e3e"
//         radius: 2
//         anchors.centerIn: parent
//         transform: Rotation {
//             origin.x: needle.width / 2
//             origin.y: needle.height
//             angle: (currentSpeed / maxSpeed) * 180
//         }
//     }

//     Rectangle {
//         width: 20
//         height: 20
//         radius: 10
//         color: "white"
//         anchors.centerIn: parent
//     }

//     Text {
//         id: speedText
//         text: Math.round(currentSpeed) + " km/h"
//         anchors.horizontalCenter: parent.horizontalCenter
//         anchors.bottom: parent.bottom
//         anchors.bottomMargin: 16
//         font.pixelSize: 34
//         font.bold: true
//         color: "white"
//     }

//     layer.enabled: true
//     layer.effect: DropShadow {
//         color: "#000000"
//         blurRadius: 12
//         offset.x: 0
//         offset.y: 0
//     }
// }
// Speedometer.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: speedometer
    width: 200
    height: 200

    // خلفية دائرية
    Rectangle {
        id: outerCircle
        width: parent.width
        height: parent.height
        radius: width / 2
        color: "#1c1c1c"
        border.color: "#444"
        border.width: 4
        anchors.centerIn: parent
    }

    // الإبرة (Needle)
    Rectangle {
        id: needle
        width: 4
        height: parent.height / 2 - 20
        color: "red"
        radius: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter

        transform: Rotation {
            id: needleRotation
            origin.x: needle.width / 2
            origin.y: needle.height
            angle: 0
        }
    }

    // Text للسرعة
    Text {
        id: speedText
        anchors.centerIn: parent
        font.pixelSize: 32
        font.bold: true
        color: "white"
        text: Math.round(speed) + " km/h"
    }

    // قيمة السرعة (مربوطة بالباك اند)
    property real speed: 0

    // تحديث دوران الإبرة حسب السرعة
    onSpeedChanged: {
        // مثلاً السرعة من 0 إلى 240 km/h
        let maxSpeed = 240;
        let maxAngle = 270;
        needleRotation.angle = (speed / maxSpeed) * maxAngle - 135;
    }
}

