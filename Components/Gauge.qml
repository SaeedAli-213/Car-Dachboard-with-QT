import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes 1.15

Item {
    id: circularGauge
    width: 300
    height: 300

    property real value: 50
    property real minimumValue: 0
    property real maximumValue: 180
    property color gaugeColor: "green"

    function angleForValue(val) {
        return (val - minimumValue) / (maximumValue - minimumValue) * 270 - 135;
    }

    Canvas {
        id: gaugeCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(width, height) / 2 * 0.8;
            var startAngle = -135 * Math.PI / 180;
            var endAngle = angleForValue(value) * Math.PI / 180;

            // Background arc
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, -135 * Math.PI / 180, 135 * Math.PI / 180);
            ctx.lineWidth = 20;
            ctx.strokeStyle = "#e0e0e0";
            ctx.stroke();

            // Value arc
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, startAngle, endAngle);
            ctx.lineWidth = 20;
            ctx.strokeStyle = gaugeColor;
            ctx.stroke();
        }
    }

    Rectangle {
        id: needle
        width: 4
        height: parent.height / 2 * 0.8
        color: "red"
        anchors.centerIn: parent
        transform: Rotation {
            origin.x: needle.width / 2
            origin.y: needle.height
            angle: angleForValue(value)
        }
    }

    Text {
        id: valueText
        text: Math.round(value).toString()
        anchors.centerIn: parent
        font.pixelSize: 24
        color: "black"
    }

    // Example of changing the gauge color based on value
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
