import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../Components"
import Style 1.0

Popup {
    signal powerOff()
    property real currentSpeed: 0
    width: 1700
    height: 600 *1.35
    background: Rectangle {
        anchors.fill: parent
        radius: 9
        color: Style.alphaColor(Style.black, 0.8)
    }

    Image{
        id:leftgauge
        sourceSize: Qt.size(root.height /1.4 ,root.height /1.4)
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenterOffset: 50
        anchors.verticalCenter: parent.verticalCenter
        source: "../icons/speeds_show/Tacometer.png"
        CircularGaugeMeter {
            id:leftIndi
            anchors.centerIn: parent
            width: parent.width * 0.79
            height: parent.height * 0.79
            value: 70
            shadowVisible: true
            maximumValue: 240
            Component.onCompleted: forceActiveFocus()
            Behavior on value { NumberAnimation { duration: 1000 }}

        }


        Label{
            text: "🍃Echo"
            font.bold: true
            font.weight: Font.Normal
            font.pixelSize: 22
            font.family: "TacticSans-Med"
            color: "#2BD150"
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -10
            anchors.verticalCenterOffset: parent.height * 0.1
            layer.effect: DropShadow {
                anchors.fill: parent
                horizontalOffset: 5
                verticalOffset: 5
                radius: 10
                samples: 16
                color: "white"
            }
        }
    }

    Image{
        source: "../icons/speeds_show/feaul.svg"
        anchors.bottom: left.top
        anchors.left: left.left
        sourceSize: Qt.size(48,48)
        anchors.bottomMargin: 5
    }

    Image{
        id:left
        source: "../icons/speeds_show/Vector 1.png"
        anchors.left: leftgauge.left
        anchors.bottom: leftgauge.bottom
        anchors.leftMargin: 10
        anchors.bottomMargin: 70
        layer.enabled: true
        layer.samplerName: "fuelShader"
        // layer.effect: ShaderEffect {
        //     id: fuelShaderMask
        //     property variant v
        //     SequentialAnimation {
        //         running: true
        //         loops: Animation.Infinite

        //         UniformAnimator {
        //             target: fuelShaderMask
        //             uniform: "v"
        //             from: 0
        //             to: 1
        //             duration: 5000
        //         }
        //         UniformAnimator {
        //             target: fuelShaderMask
        //             uniform: "v"
        //             from: 1
        //             to: 0
        //             duration: 5000
        //         }
        //     }
        //     fragmentShader: "
        //          uniform lowp sampler2D fuelShader;
        //          uniform lowp float qt_Opacity;
        //          varying highp vec2 qt_TexCoord0;
        //          uniform lowp float v;
        //          void main() {
        //             const lowp vec3 c1 = vec3(0.502,0.545,0.11);
        //             const lowp vec3 c2 = vec3(0.247,0.78,0.871);
        //             lowp vec3 bg = mix(c1, c2, 1.0 - qt_TexCoord0.y);

        //             // Animated ramp
        //             lowp float s = smoothstep(0.99 - v, 1.01 - v, 1.0 - qt_TexCoord0.y);
        //             lowp vec3 ramp = vec3(s);
        //             lowp vec4 color = vec4(bg + ramp, 1.0);

        //             gl_FragColor = color * texture2D(fuelShader, qt_TexCoord0).a * qt_Opacity;
        //          }
        //      "
        // }
    }
    Image{
        id:topBar
        source: "../icons/speeds_show/bottom.png"
        sourceSize: Qt.size(root.width * 0.6,150)
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter


        RowLayout{
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.verticalCenter: parent.verticalCenter
            spacing: 7
            Image{
                source: "../icons/speeds_show/cloud.svg"
                sourceSize: Qt.size(24,24)
            }
            Label{
                text: qsTr("12 °C")
                font.pixelSize: 24
                font.bold: true
                font.weight: Font.Normal
                color: "#FFFFFF"
                font.family: "TacticSans-Med"
            }
        }

        Label{
            id:timeLabel
            text: new Date().toLocaleTimeString(Qt.locale(), "hh:mm AP")
            anchors.right: parent.right
            anchors.rightMargin: 80
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 24
            font.bold: true
            font.weight: Font.Normal
            font.family: "TacticSans-Med"
            color: "#FFFFFF"
        }
    }
    RowLayout{
        width: topBar.width * 0.5
        anchors.top: topBar.bottom
        anchors.horizontalCenter: topBar.horizontalCenter
        anchors.horizontalCenterOffset: 40
        Item{
            Layout.fillWidth: true
        }

        Image{
            Layout.alignment: Qt.AlignHCenter
            source: "../icons/speeds_show/mdi_turn-right-bold.svg"
            sourceSize: Qt.size(85,85)
        }

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter
            Text{
                font.pixelSize: 32
                font.bold: true
                font.weight: Font.Normal
                font.family: "TacticSans-Blk"
                color: "#FFFFFF"
                text: qsTr("372 m")
            }
            Text{
                font.pixelSize: 14
                font.bold: true
                font.weight: Font.Normal
                font.family: "TacticSans-Lgt"
                color: "#00D1FF"
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: qsTr("Enter St. Street and \ntake first right")
            }
            Item{
                Layout.preferredHeight: 25
            }
        }
        Item{
            Layout.fillWidth: true
        }
    }
    Image{
        source: "../icons/speeds_show/mingcute_steering-wheel-fill.svg"
        sourceSize: Qt.size(95,95)
        anchors.top: topBar.bottom
        anchors.horizontalCenter: topBar.horizontalCenter
        anchors.horizontalCenterOffset: 230
        anchors.topMargin: 10
    }


    Image{
        source: "../icons/speeds_show/ss.svg"
        sourceSize: Qt.size(95-20,114-20)
        scale: 0.9
        anchors.top: topBar.bottom
        anchors.horizontalCenter: topBar.horizontalCenter
        anchors.horizontalCenterOffset: -230
        anchors.topMargin: 10

        Text{
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 20
            font.pixelSize: 36
            font.bold: true
            font.weight: Font.Normal
            font.family: "TacticSans-Blk"
            color: "#090C14"
            text: qsTr("90")
        }
    }

    Image{
        id:roadImage2
        visible: true
        anchors.centerIn: parent
        source: "../icons/speeds_show/road3.svg"
        anchors.verticalCenterOffset: 40
        sourceSize.height: parent.height * 0.74

        Image{
            id:mainCar
            source: "../icons/speeds_show/car.png"
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 38
            anchors.verticalCenterOffset: 110
        }
        Image{
            sourceSize: Qt.size(mainCar.width*0.5,mainCar.height * 0.5)
            source: "../icons/speeds_show/car.png"
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -30
            anchors.verticalCenterOffset: -100
        }
    }

    Timer {
        id: speedUpdateTimer
        interval: 500
        running: true
        repeat: true
        onTriggered: backend.fetch_vehicle_speed()
    }


    Image{
        id:rightgaugae
        sourceSize: Qt.size(root.height /1.55 ,root.height /1.55)
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.verticalCenterOffset: 50
        anchors.verticalCenter: parent.verticalCenter
        source: "../icons/speeds_show/Speedometer.png"
        CircularGaugeMeter {
            id:rightGuage
            anchors.centerIn: parent
            width: parent.width * 0.85
            height: parent.height * 0.85
            value: currentSpeed
            maximumValue: 220
            shadowVisible: true
            Behavior on value { NumberAnimation { duration: 1000 }}
        }


        Label{
            text: "🍃Echo"
            font.bold: true
            font.weight: Font.Normal
            font.pixelSize: 22
            font.family: "TacticSans-Med"
            color: "#2BD150"
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -10
            anchors.verticalCenterOffset: parent.height * 0.1
            layer.effect: DropShadow {
                anchors.fill: parent
                horizontalOffset: 5
                verticalOffset: 5
                radius: 10
                samples: 16
                color: "white"
            }
        }
    }
    Image{
        source: "../icons/speeds_show/desal.svg"
        anchors.bottom: right.top
        anchors.right: right.right
        sourceSize: Qt.size(48,48)
        anchors.bottomMargin: 5
    }

    Image{
        id:right
        source:  "../icons/speeds_show/Vector 1.png"
        mirror: true
        anchors.left: rightgaugae.left
        anchors.leftMargin: rightgaugae.width /2
        anchors.bottom: rightgaugae.bottom
        anchors.bottomMargin: 40
        smooth: true
        asynchronous: true
        layer.enabled: true
        layer.samplerName: "fuelShader"
        // layer.effect: ShaderEffect {
        //     id: fuelShaderMask2
        //     property variant v
        //     SequentialAnimation {
        //         running: true
        //         loops: Animation.Infinite

        //         UniformAnimator {
        //             target: fuelShaderMask2
        //             uniform: "v"
        //             from: 0
        //             to: 1
        //             duration: 5000
        //         }
        //         UniformAnimator {
        //             target: fuelShaderMask2
        //             uniform: "v"
        //             from: 1
        //             to: 0
        //             duration: 5000
        //         }
        //     }

        //     fragmentShader: "
        //          uniform lowp sampler2D fuelShader;
        //          uniform lowp float qt_Opacity;
        //          varying highp vec2 qt_TexCoord0;
        //          uniform lowp float v;

        //          void main() {
        //             const lowp vec3 c1 = vec3(0.502,0.545,0.11);
        //             const lowp vec3 c2 = vec3(0.247,0.78,0.871);
        //             lowp vec3 bg = mix(c1, c2, 1.0 - qt_TexCoord0.y);

        //             // Animated ramp
        //             lowp float s = smoothstep(0.99 - v, 1.01 - v, 1.0 - qt_TexCoord0.y);
        //             lowp vec3 ramp = vec3(s);
        //             lowp vec4 color = vec4(bg + ramp, 1.0);

        //             gl_FragColor = color * texture2D(fuelShader, qt_TexCoord0).a * qt_Opacity;
        //          }
        //      "
        // }
    }

    Image{
        sourceSize: Qt.size((topBar.width-35),(topBar.height-35))
        source: "../icons/speeds_show/bottom.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }

    RowLayout{
        width: roadImage2.width * 0.6
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 220
        spacing : 20
        // anchors.horizontalCenterOffset: 20

        Image{
            Layout.alignment: Qt.AlignLeft
            source: "../icons/speeds_show/mdi_map-marker-outline.svg"
            sourceSize: Qt.size(28,28)
        }

        Label{
            Layout.alignment: Qt.AlignLeft
            font.pixelSize: 24
            font.bold: true
            font.weight: Font.Normal
            font.family: "TacticSans-Med"
            text: qsTr("26 KM")
            color: "#FFFFFF"
        }

        Item{
            Layout.fillWidth: true
        }

        Image{
            Layout.alignment: Qt.AlignRight
            source: "../icons/speeds_show/mdi_clock-time-four-outline.svg"
            sourceSize: Qt.size(28,28)
        }

        Label{
            Layout.alignment: Qt.AlignRight
            font.pixelSize: 24
            font.bold: true
            font.weight: Font.Normal
            font.family: "TacticSans-Med"
            text: qsTr("22 Min")
            color: "#FFFFFF"
        }

    }



    // Speedometer {
    //        id: mySpeedometer
    //        speed: currentSpeed
    //    }

    Connections {
        target: backend

        function onVehicle_speed_updated(speed) {
            currentSpeed = speed
        }
    }


}
