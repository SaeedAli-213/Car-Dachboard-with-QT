import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0

RowLayout {
    spacing: 48
    property int temp: 72
    property bool airbagOn: false

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered:{
            currentTime.text = Qt.formatDateTime(new Date(), "hh:mm ap")
        }
    }
    Text {
        id: currentTime
        text: Qt.formatDateTime(new Date(), "hh:mm")
        font.pixelSize: 18
        font.family: "Inter"
        font.bold: Font.DemiBold
        color: Style.isDark ? Style.white : Style.black20
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
    }
    Text {
        id: currentDate
        text: Qt.formatDateTime(new Date(), "dd/MM/yyyy")
        font.pixelSize: 18
        font.family: "Inter"
        font.bold: Font.DemiBold
        color: Style.isDark ? Style.white : Style.black20
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

    }

    Text {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        text: "%0ºF".arg(temp)
        font.family: "Inter"
        font.pixelSize: 18
        font.bold: Font.DemiBold
        color: Style.isDark ? Style.white : Style.black20
    }

    Control {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        implicitHeight: 38
        background: Rectangle {
            color: Style.isDark ? Style.alphaColor(Style.black,
                                                   0.55) : Style.black20
            radius: 7
        }
        contentItem: RowLayout {
            spacing: 10
            anchors.centerIn: parent
            Image {
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.leftMargin: 10
                source: "../icons/top_header_icons/airbag_.svg"
            }
            Text {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.rightMargin: 10
                text: airbagOn ? "PASSENGER\nAIRBAG ON" : "PASSENGER\nAIRBAG OFF"
                font.family: Style.fontFamily
                font.bold: Font.Bold
                font.pixelSize: 12
                color: Style.white
            }
        }
    }
}
