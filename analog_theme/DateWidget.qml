// DM Feb 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
    
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

    // Show date
    Row {

        anchors.centerIn: parent

        Text {
            text: currDate.day.toUpperCase()
            font.pixelSize: 100
            font.bold: true
            color: settings.color2
        }


        Text {
            text: currDate.date
            font.pixelSize: 100
            color: "white"
        }
    }
}