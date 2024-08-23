// DM June 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    id: weatherWidget

    property int textSize: widgetRadius*(21/32)
    
    // Draw background circle
    Rectangle {
        x: -widgetRadius
        y: -widgetRadius
        height: widgetRadius*2
        width: widgetRadius*2
        color: settings.color4
        radius: width/2
    }

    Item {
        id: weatherText
        visible: true

        Row { 

            anchors.centerIn: parent

            Column {

                anchors.verticalCenter: parent.verticalCenter

                spacing: -widgetRadius*(1/8)

                Text {
                    id: lowTemp
                    text: currTemp.tempL
                    font.pixelSize: textSize*(0.45)
                    font.bold: true
                    color: settings.color2
                }  

                Text {
                    text: currTemp.tempH
                    font.pixelSize: textSize*(0.45)
                    font.bold: true
                    color: settings.color1   
                }  
            }


            // Text for current temp
            Text {
                id: mainText
                text: currTemp.temp + "\u00B0"
                font.pixelSize: textSize
                color: "white"   
            } 
        } 
    }

    ErrorIcon {
        id: errorIcon
        visible: false
        anchors.centerIn: parent
        width: widgetRadius*(15/16)
        height: widgetRadius*(15/16)

        MouseArea {
            anchors.fill: parent
            onClicked: errorMsg.open()
        }
    }

    states: [
        State {
            name: "error"
            PropertyChanges { target: weatherText; visible: false }
            PropertyChanges { target: errorIcon; visible: true }
        }
    ]

    Connections {
        target: backend
        
        function onTemp() {

            // Determine the error state 
            if (currTemp.tempErr == 0) {
                weatherWidget.state = ""
            }
            else {
                weatherWidget.state = "error"
            }
        }
    }
}