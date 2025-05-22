import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Qt5Compat.GraphicalEffects
import Style 1.0

Item {
    id: root
    width: 200
    height: 60

    // خصائص قابلة للتخصيص
    property alias iconSource: icon.source
    property alias buttonText: label.text
    property bool isGlow: false

    // الزر الأساسي
    Rectangle {
        id: button
        anchors.fill: parent
        color: Style.black20
        radius: 10
        border.color: Style.black10
        border.width: 2

        // تخطيط الصورة والنص بجانب بعضهما
        RowLayout {
            anchors.centerIn: parent
            spacing: 5

            Image {
                id: icon
                source: ""
                width: 20
                height: 2
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: label
                text: ""
                font.pixelSize: 18
                color: Style.white
                font.bold: true
            }
        }

        // منطقة التفاعل
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                root.clicked()
            }
        }
    }

    // تأثير التوهج
    Glow {
        anchors.fill: button
        source: button
        radius: 10
        samples: 16
        color: Style.black50
        transparentBorder: true
        visible: isGlow && (mouseArea.containsMouse || mouseArea.pressed)
    }

    // إشارة النقر
    signal clicked()
}
