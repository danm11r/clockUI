// DM Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    // Draw the background circle
    Shape {
        ShapePath {
            fillColor: settings.bgcolor
            strokeColor: settings.bgcolor   
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

    Repeater {

        model: time.second+1

        Rectangle {
            x: - arcWidth/4
            y: - widgetRadius
            width: arcWidth/2
            height: arcWidth
            radius: 180
            color: settings.color1

            transform: Rotation { origin.x: arcWidth/4; origin.y: widgetRadius; angle: index*6 } 
        }
    }

    // Draw a red dot if PM
    Rectangle {
        visible: time.PM
        x: - arcWidth
        y: widgetRadius/2
        width: arcWidth*2
        height: arcWidth
        radius: 180
        color: settings.accent
    }

    // Display current time
    Text {
        id: hour
        anchors.centerIn: parent
        text: time.hour_text + ":" + time.minute_text
        font.pixelSize: textSize
        color: "white"
    }
}