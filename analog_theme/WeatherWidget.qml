// DM June 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    id: weatherWidget
    
    // Draw background circle
    Shape {

        ShapePath {
            fillColor: settings.color4
            strokeColor: settings.color4   
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 0
                sweepAngle: 360
            }
        } 
    }

    Item {
        id: weatherText
        visible: true

        Row { 

            anchors.centerIn: parent

            Column {

                anchors.verticalCenter: parent.verticalCenter

                spacing: -20

                Text {
                    id: lowTemp
                    text: currTemp.tempL
                    font.pixelSize: textSize*(0.42)
                    font.bold: true
                    color: settings.color2
                }  

                Text {
                    text: currTemp.tempH
                    font.pixelSize: textSize*(0.42)
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
        width: 150
        height: 150

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
            else if (currTemp.tempErr == 1 || currTemp.tempErr == 2) {
                weatherWidget.state = "error"
            }
        }
    }
}