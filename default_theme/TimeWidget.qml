// Daniel Miller Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    // Draw the background circle
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

    // Draw second marks
    Repeater {

        model: 60

        Rectangle {
            x: - arcWidth/4
            y: - widgetRadius
            width: arcWidth/2
            height: arcWidth
            radius: 180
            color: "#B4B4B4"

            transform: Rotation { origin.x: arcWidth/4; origin.y: widgetRadius; angle: index*6 } 
        }
    }

    // Draw mark corresponding to current second
    Repeater {

        model: hms.sec+1

        Rectangle {
            x: - arcWidth/4
            y: - widgetRadius
            width: arcWidth/2
            height: arcWidth
            radius: 180
            color: primary

            transform: Rotation { origin.x: arcWidth/4; origin.y: widgetRadius; angle: index*6 } 
        }
    }

    // Draw a red dot if PM
    Rectangle {
        visible: currTime.PM
        x: - arcWidth
        y: widgetRadius/2
        width: arcWidth*2
        height: arcWidth
        radius: 180
        color: "#CE2029"
    }

    // Display current time
    Text {
        anchors.centerIn: parent
        text: currTime.time
        font.pixelSize: textSize
        color: "white"   
    }
}