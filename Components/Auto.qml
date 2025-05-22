import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: control
    property string labelText: "Auto Drive"
    property bool isGlow: false
    signal clicked()

    width: Math.max(contentRow.implicitWidth + 40, 220)
    height: 70

    Rectangle {
        id: background
        anchors.fill: parent
        radius: 15
        color: Qt.rgba(1, 1, 1, 0.1)       // شفافية خفيفة أبيض
        border.color: control.focus ? "#29BEB6" : "#FFFFFF33"  // لون حدود هادي مع تغير عند التركيز
        border.width: 2

        // ظل بسيط
        layer.enabled: true
        layer.effect: DropShadow {
            color: "#00000040"
            radius: 8
            samples: 12
            verticalOffset: 2
        }

        Row {
            id: contentRow
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: labelText
                color: "white"
                font.pixelSize: 28
                font.bold: true
                font.family: "Roboto" // أو أي فونت أنيق تفضله
                verticalAlignment: Text.AlignVCenter
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onClicked: {
                control.clicked()
            }

            onPressed: {
                background.color = Qt.rgba(1, 1, 1, 0.15)
            }
            onReleased: {
                background.color = Qt.rgba(1, 1, 1, 0.1)
            }
            onExited: {
                background.color = Qt.rgba(1, 1, 1, 0.1)
            }
        }
    }
}
