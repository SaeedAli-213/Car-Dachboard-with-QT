import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Style 1.0
// import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import "../Components"

// Popup {
//     // width: 1104
//     // // height: 445
//     width: 1400*1.2
//     height: 600 *1.4
    // background: Rectangle {
    //     anchors.fill: parent
    //     radius: 9
    //     color: Style.alphaColor(Style.black, 0.8)
    // }
Popup {
    width: 1400*1.2
    height: 600 *1.4
    background: Rectangle {
        anchors.fill: parent
        radius: 9
        color: Style.alphaColor(Style.black, 0.8)
    }
    GridLayout {
        id: grid
        anchors.fill: parent
        anchors.rightMargin: 50
        anchors.bottomMargin: 20
        anchors.topMargin: 20

        rows: 1
        columns: 2
        rowSpacing: 20
        columnSpacing: 20

        RowLayout {
            spacing : 50
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            ColumnLayout {
                spacing: 20
                Layout.row: 0
                Layout.column: 0
                Layout.columnSpan: 1
                Layout.rowSpan: 1

                DateTimeTile {}

                BattreyTitle {}

                MediaControlFile {
                    id: mediaControl
                }

            }
            ColumnLayout {
                spacing: 20
                Layout.row: 0
                Layout.column: 0
                Layout.columnSpan: 1
                Layout.rowSpan: 1

                LargeTileMusic {
                    musicStationConnected: mediaControl.mediaControlSelected
                }

                MusicListTile {
                    musicStationConnected: mediaControl.mediaControlSelected
                }
            }

            ColumnLayout {
                spacing: 20
                Layout.row: 0
                Layout.column: 0
                Layout.columnSpan: 1
                Layout.rowSpan: 1

                WeatherTile {
                    id: weatherTile
                }

                SeatTile {
                    title: qsTr("Driver’s Seat")
                    temperature: 70
                    heatSeatChecked: false
                    fanSeatChecked: true
                    celsius: weatherTile.celsius
                }
            }

            ColumnLayout {
                spacing: 20
                Layout.row: 0
                Layout.column: 1
                Layout.columnSpan: 1
                Layout.rowSpan: 1

                AirControlTile {}

                SeatTile {
                    title: qsTr("Back Seat")
                    temperature: 68
                    heatSeatChecked: true
                    fanSeatChecked: false
                    celsius: weatherTile.celsius
                }
            }


        }








}
}
