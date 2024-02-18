// DM Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

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

    Shape {

        ShapePath {
            fillColor: "transparent"
            strokeColor: color1
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 270
                sweepAngle: currDate.datePos

                Behavior on sweepAngle {
                    SmoothedAnimation { 
                        velocity: 30 
                        duration: 250
                    }
                } 
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: -20
            text: currDate.date
            font.pixelSize: textSize  //44
            color: "white"   
        }  

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: -20
            text: currDate.day
            font.pixelSize: textSize  //38
            color: color1
        }  
    }
}