// DM Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    id: weatherWidget

    property double tempPos: 0

    // Draw background circle
    Shape {
        ShapePath {
            fillColor: "#2A2A2A"
            strokeColor: "#2A2A2A"   
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
            strokeColor: settings.color1
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 90
                sweepAngle: tempPos

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
                sweepAngle: -tempPos

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
            text: currTemp.temp + "\u00B0" + "F"
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
                color: settings.color1
            } 

            Text {
                text: currTemp.tempH
                font.pixelSize: textSize/2
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

            if (currTemp.tempH != currTemp.tempL) {
                tempPos = (((currTemp.temp - currTemp.tempL) * (179)) / (currTemp.tempH - currTemp.tempL))
            }
            else {
                tempPos = 180
            }

            // Determine the error state 
            if (currTemp.tempErr == 0) {
                weatherWidget.state = ""
            }
            else {
                weatherWidget.state = "error"
                tempPos = 0
            }
        }
    }   
}
