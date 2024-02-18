// DM Feb 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
    
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

    // Show date
    Row {

        anchors.centerIn: parent

        Text {
            text: currDate.day.toUpperCase()
            font.pixelSize: 90
            font.bold: true
            color: color2
        }


        Text {
            text: currDate.date
            font.pixelSize: 90
            color: "white"
        }
    }
}