// import QtQuick 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15
// import QtQuick.Shapes 1.15

// Item {
//     id: circularGauge
//     width: 300
//     height: 300

//     property real value: 50
//     property real minimumValue: 0
//     property real maximumValue: 180
//     property color gaugeColor: "green"

//     function angleForValue(val) {
//         return (val - minimumValue) / (maximumValue - minimumValue) * 270 - 135;
//     }

//     Canvas {
//         id: gaugeCanvas
//         anchors.fill: parent
//         onPaint: {
//             var ctx = getContext("2d");
//             ctx.reset();
//             var centerX = width / 2;
//             var centerY = height / 2;
//             var radius = Math.min(width, height) / 2 * 0.8;
//             var startAngle = -135 * Math.PI / 180;
//             var endAngle = angleForValue(value) * Math.PI / 180;

//             // Background arc
//             ctx.beginPath();
//             ctx.arc(centerX, centerY, radius, -135 * Math.PI / 180, 135 * Math.PI / 180);
//             ctx.lineWidth = 20;
//             ctx.strokeStyle = "#e0e0e0";
//             ctx.stroke();

//             // Value arc
//             ctx.beginPath();
//             ctx.arc(centerX, centerY, radius, startAngle, endAngle);
//             ctx.lineWidth = 20;
//             ctx.strokeStyle = gaugeColor;
//             ctx.stroke();
//         }
//     }

//     Rectangle {
//         id: needle
//         width: 4
//         height: parent.height / 2 * 0.8
//         color: "red"
//         anchors.centerIn: parent
//         transform: Rotation {
//             origin.x: needle.width / 2
//             origin.y: needle.height
//             angle: angleForValue(value)
//         }
//     }

//     Text {
//         id: valueText
//         text: Math.round(value).toString()
//         anchors.centerIn: parent
//         font.pixelSize: 24
//         color: "black"
//     }

//     // Example of changing the gauge color based on value
//     onValueChanged: {
//         if (value < 60) {
//             gaugeColor = "#32D74B";
//         } else if (value < 150) {
//             gaugeColor = "yellow";
//         } else {
//             gaugeColor = "red";
//         }
//         gaugeCanvas.requestPaint();
//     }
// }


import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes 1.15
import Qt5Compat.GraphicalEffects

Item {
    id: circularGauge
    width: 300
    height: 300
    property bool shadowVisible: true

    property real value: 50
    property real minimumValue: 0
    property real maximumValue: 180
    property color gaugeColor: "green"
    property real startAngle: -120
    property real endAngle: 120

    function angleForValue(val) {
        return (val - minimumValue) / (maximumValue - minimumValue) * (endAngle - startAngle) + startAngle;
    }

    Canvas {
        id: gaugeCanvas
        visible: shadowVisible

        anchors.fill: parent

        function degreesToRadians(degrees) {
            return degrees * (Math.PI / 180);
        }

        function createLinearGradient(ctx, start, end, colors) {
            var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
            for (var i = 0; i < colors.length; i++) {
                gradient.addColorStop(i / (colors.length - 1), colors[i]);
            }
            return gradient;
        }
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            // Define the gradient colors for the filled arc
            var gradientColors = [
                        "#D9D9D9",// Start color
                        "#D9D9D9",    // End color
                    ];

            // Calculate the start and end angles for the filled arc
            var startAngle = valueToAngle(gauge.minimumValue) - 90;
            var endAngle = valueToAngle(gauge.value) - 90;

            // Create a linear gradient
            var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);

            // Loop through the gradient colors and fill the arc segment with each color
            for (var i = 0; i < gradientColors.length; i++) {
                var gradientColor = gradientColors[i];
                var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                ctx.beginPath();
                ctx.lineWidth = outerRadius * 0.15;
                ctx.strokeStyle = gradient;
                ctx.arc(outerRadius,
                        outerRadius,
                        outerRadius - 48,
                        degreesToRadians(angle),
                        degreesToRadians(endAngle));
                ctx.stroke();
            }
        }
    }

    Rectangle {
        id: needle
        width: 5
        height: parent.height / 2 * 0.7
        color: "red"
        radius: 2
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -100
        transform: Rotation {
            origin.x: needle.width / 2
            origin.y: needle.height +10
            angle: angleForValue(value)
        }

        // Add a shadow behind the needle (optional)
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 1
            verticalOffset: 1
            radius: 4
            color: "#88000000"
        }
    }

    // Central Circle
    Rectangle {
        width: 20
        height: 20
        radius: 10
        color: "black"
        anchors.centerIn: parent
    }

    Text {
        id: valueText
        text: Math.round(value).toString()
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        font.pixelSize: 24
        color: "black"
    }

    // Dynamic color change
    onValueChanged: {
        if (value < 60) {
            gaugeColor = "#32D74B";
        } else if (value < 150) {
            gaugeColor = "yellow";
        } else {
            gaugeColor = "red";
        }
        gaugeCanvas.requestPaint();
    }
}

