// DM Feb 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    width: widgetRadius*2
    height: widgetRadius*2

    x: -widgetRadius
    y: -widgetRadius
    
    // Draw background circle
    Rectangle {
        anchors.fill: parent
        color: settings.color4
        radius: width/2
    }

    // Show date
    Row {

        anchors.centerIn: parent

        // Dummy text used to determine proper font size for actual text below
        Text {
            id: dummyText
            visible: false
            text: currDate.day.toUpperCase() + currDate.date
            width: widgetRadius*(8/5)
            fontSizeMode: Text.Fit
            font.pixelSize: widgetRadius*(0.625)
        }

        Text {
            id: text
            text: currDate.day.toUpperCase()
            font.pixelSize: dummyText.fontInfo.pixelSize
            font.bold: true
            color: settings.color2
        }


        Text {
            text: currDate.date
            font.pixelSize: dummyText.fontInfo.pixelSize
            color: "white"
        }
    }
}