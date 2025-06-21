import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0
// import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

Item {
    height: 120
    width: parent.width
    signal openLauncher
    signal openCamera
    signal openBattery
    signal openCarSetting
    signal openSpeedshow
    LinearGradient {
        anchors.fill: parent
        start: Qt.point(0, 0)
        end: Qt.point(0, 1000)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Style.black
            }
            GradientStop {
                position: 1.0
                color: Style.black60
            }
        }
    }

    Icon {
        id: leftControl
        icon.source: "../icons/app_icons/model-3.svg"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 36
        onClicked: openLauncher()
    }

    Item {
        height: parent.height
        anchors.left: leftControl.right
        anchors.right: middleLayout.left
        anchors.verticalCenter: parent.verticalCenter

        StepperControl {
            anchors.centerIn: parent
            value: 72
        }
    }

    RowLayout {
        id: middleLayout
        anchors.centerIn: parent
        spacing: 35

        Icon {
            icon.source: "../icons/app_icons/phone.svg"
        }

        Icon {
            icon.source: "../icons/app_icons/radio.svg"
        }

        Icon {
            icon.source: "../icons/app_icons/bluetooth.svg"
        }

        Icon {
            isGlow: true
            icon.source: "../icons/app_icons/spotify.svg"
        }

        Icon {
            isGlow: true
            icon.source: "../icons/app_icons/dashcam.svg"
            onClicked:{
                backend.start_front_camera()
                // Style.mapAreaVisible = !Style.mapAreaVisible
                openCamera()
            }
        }

        Icon {
            icon.source: "../icons/app_icons/video.svg"
        }

        Icon {
            icon.source: "../icons/app_icons/battery.svg"
            onClicked: openBattery()
        }

        Icon {
            icon.source: "../icons/icon_battrey/Car Settings Icon.svg"
            onClicked: openCarSetting()
        }

        Icon {
            icon.source: "../icons/icon_battrey/Car Settings Icon.svg"
            onClicked: openSpeedshow()
        }

    }

    Item {
        height: parent.height
        anchors.right: rightControl.left
        anchors.left: middleLayout.right
        anchors.verticalCenter: parent.verticalCenter

        StepperControl {
            anchors.centerIn: parent
            value: 72
        }
    }

    StepperControl {
        id: rightControl
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 36
        value: 72
        icon: "../icons/app_icons/volume.svg"
    }
}
