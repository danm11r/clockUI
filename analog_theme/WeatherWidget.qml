// DM Feb 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    id: weatherWidget
    
    // Draw background circle
    Shape {

        ShapePath {
            fillColor: color4
            strokeColor: color4   
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

                spacing: -30

                Text {
                    id: lowTemp
                    text: currTemp.tempL
                    font.pixelSize: 60
                    font.bold: true
                    color: color2
                }  

                Text {
                    text: currTemp.tempH
                    font.pixelSize: 60
                    font.bold: true
                    color: color1   
                }  
            }


            // Text for current temp
            Text {
                id: mainText
                text: currTemp.temp
                font.pixelSize: textSize
                color: "white"   
            } 

        } 
    }

    // API error message
    Text {
        id: apiError
        anchors.centerIn: parent
        visible: false
        text: "API Err"
        font.pixelSize: 80
        color: "white"   
    }  

    // Network error message
    Text {
        id: networkError
        anchors.centerIn: parent
        visible: false
        text: "Net Err"
        font.pixelSize: 80
        color: "white"   
    }  

    states: [
        State {
            name: "error1"
            PropertyChanges { target: weatherText; visible: false }
            PropertyChanges { target: apiError; visible: true }
        },
        State {
            name: "error2"
            PropertyChanges { target: weatherText; visible: false }
            PropertyChanges { target: networkError; visible: true }
        }
    ]

    Connections {
        target: backend
        
        function onTemp(temp, tempL, tempH, tempPos, tempErr) {
            currTemp = {'temp': temp, 'tempL': tempL, 'tempH': tempH,'tempPos': tempPos, 'tempErr': tempErr}
            
            // Determine the error state 
            if (currTemp.tempErr == 0) {
                weatherWidget.state = ""
            }
            else if (currTemp.tempErr == 1) {
                weatherWidget.state = "error1"
            }
            else if (currTemp.tempErr == 2) {
                weatherWidget.state = "error2"
            }
        }
    }
}
