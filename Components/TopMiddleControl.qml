import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0

RowLayout {
    spacing: 32
    property bool locked: false
    Icon {
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        // icon.source: locked ? (Style.isDark ? "../icons/top_header_icons/dark/unlock.png" : "../icons/top_header_icons/unlock.png") : (Style.isDark ? "../icons/top_header_icons/dark/lock.svg" : "../icons/top_header_icons/lock.svg")

        icon.source: Style.isDark ? "../icons/top_header_icons/dark/lock.svg" : "../icons/top_header_icons/lock.svg"
        onClicked: {
            locked = !locked
            Style.mapAreaVisible = !Style.mapAreaVisible
        }
    }
   //icons/top_header_icons/Vector 70.svg
    RowLayout {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: 15
        Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            sourceSize: Qt.size(42, 42)
            source: Style.isDark ? "../icons/top_header_icons/dark/icons.svg" : "../icons/top_header_icons/icons.svg"
        }
        Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 18
            font.bold: Font.DemiBold
            font.family: "Inter"
            color: Style.isDark ? Style.white : Style.black20
            text: qsTr("Team BSU")
        }
    }

    Icon {
        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        scale: 0.95
        icon.source: Style.isDark ? "../icons/top_header_icons/dark/Sentry.svg" : "../icons/top_header_icons/Sentry.svg"
        onClicked: Style.isDark = !Style.isDark
    }
}
