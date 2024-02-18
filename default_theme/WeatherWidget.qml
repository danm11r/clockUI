// DM Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    id: weatherWidget

    // Draw background circle
    Shape {
        ShapePath {
            fillColor: bgcolor
            strokeColor: bgcolor   
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
           
    // Draw temp guage
    Shape {

        id: tempGauge

        ShapePath {
            fillColor: "transparent"
            strokeColor: color1
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 90
                sweepAngle: currTemp.tempPos

                Behavior on sweepAngle {
                    SmoothedAnimation { 
                        velocity: 30 
                        duration: 250
                    }
                } 
            }                

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 90 
                sweepAngle: -currTemp.tempPos

                Behavior on sweepAngle {
                    SmoothedAnimation { 
                        velocity: 10 
                        duration: 250
                    }
                } 
            }      
        } 
    }

    Item {
        id: weatherText
        visible: true

        // Text for current temp
        Text {
            id: mainText
            anchors.centerIn: parent
            text: currTemp.temp + "F"
            font.pixelSize: textSize
            color: "white"   
        }  

        Row {

            spacing: 10

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: mainText.bottom
            anchors.topMargin: -30

            Text {
                id: lowTemp
                text: currTemp.tempL
                font.pixelSize: textSize/2
                color: "white"   
            }  

            // Draw divider
            Rectangle {
                anchors.verticalCenter: lowTemp.verticalCenter
                width: arcWidth
                height: arcWidth*2
                radius: 180
                color: color1
            } 

            Text {
                text: currTemp.tempH
                font.pixelSize: textSize/2
                color: "white"   
            }  
        }
    }

    // API error message
    Text {
        id: apiError
        visible: false
        anchors.centerIn: parent
        text: "API Err"
        font.pixelSize: 80
        color: "white"   
    }  

    // Network error message
    Text {
        id: networkError
        visible: false
        anchors.centerIn: parent
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
