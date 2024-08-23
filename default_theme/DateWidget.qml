// DM Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    property int datePos: 0

    // Draw background circle
    Rectangle {
        x: -widgetRadius
        y: -widgetRadius
        height: widgetRadius*2
        width: widgetRadius*2
        color: settings.bgcolor
        radius: width/2
    }

    Shape {

        ShapePath {
            fillColor: "transparent"
            strokeColor: settings.color1
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 270
                sweepAngle: datePos

                Behavior on sweepAngle {
                    SmoothedAnimation { 
                        velocity: 30 
                        duration: 250
                    }
                } 
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: -widgetRadius*(5/19)

            Text {
                text: currDate.day
                font.pixelSize: textSize
                color: settings.color1
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: currDate.date
                font.pixelSize: textSize
                color: "white"   
            }
        }
    }

    Connections {
        target: backend
        
        function onDate() {

            datePos = currDate.date*360 / currDate.totalDays

        }
    }   
}