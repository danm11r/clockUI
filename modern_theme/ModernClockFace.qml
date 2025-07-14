// DM July 2025
// clockUI
// 
// Modern clock face

import QtQuick

Item {

    id: modernClockFace

    height: clockRadius*2
    width: clockRadius*2

    property string hour
    property string minute
    property int textSize: clockRadius*(11/27)
    property int arcWidth: clockRadius*(2/45)

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: -50

        spacing: 0

        // Pad time text with 0 for digits less than 10
        Text {
            visible: (settings.time24hr ? (time.hour < 10 ? true : false) : ((time.hour % 12) <  10 ? true : false))
            text: "0"
            font.pixelSize: 250
            font.bold: true
            font.italic: true
            color: settings.color1
        }  

        Text {
            visible: true
            text: (settings.time24hr ? time.hour_24_text : time.hour_12_text)
            font.pixelSize: 250
            font.bold: true
            font.italic: true
            color: settings.color1
        }

        // Dummy text used for spacing digits in row
        Text {
            text: "0"
            font.pixelSize: 250
            font.bold: true
            font.italic: true
            color: "transparent"
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        anchors.topMargin: -50

        spacing: 0

        // Dummy text used for spacing digits in row
        Text {
            text: "0"
            font.pixelSize: 250
            font.bold: true
            font.italic: true
            color: "transparent"
        }  

        Text {
            text: time.minute_text
            font.pixelSize: 250
            font.bold: true
            font.italic: true
            color: settings.color2
        }
    }
}