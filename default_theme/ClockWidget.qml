// DM Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    // Draw background circle. It would be easier to do this with a rectangle... 
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

    // Draw second marks around widget circumference
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

    // Draw the hour marks
    Repeater {

        model: 12

        Rectangle {
            x: - arcWidth/4
            y: - widgetRadius
            width: arcWidth/2
            height: arcWidth*2
            radius: 180
            color: "#B4B4B4"

            transform: Rotation { origin.x: arcWidth/4; origin.y: widgetRadius; angle: index*30 } 
        }
    }

    // Minute hand
    Rectangle {
        x: -arcWidth/4
        y: -arcWidth/4
        width: arcWidth/2
        height: Math.round(widgetRadius*(3/4))+arcWidth/4
        radius: 180
        color: settings.color1

        transform: Rotation { origin.x: arcWidth/4; origin.y: arcWidth/4; angle: time.minute*6 + 180 } 
    }

    // Hour hand
    Rectangle {
        x: -arcWidth/4
        y: -arcWidth/4
        width: arcWidth/2
        height: widgetRadius/2+arcWidth/4
        radius: 180
        color: settings.color2

        transform: Rotation { origin.x: arcWidth/4; origin.y: arcWidth/4; angle: time.hour*30 + 180 } 
    }

    // Second hand
    Rectangle {
        x: -arcWidth/4
        y: -arcWidth/4
        width: arcWidth/2
        height: widgetRadius+arcWidth/4
        radius: 180
        color: settings.accent

        transform: Rotation { origin.x: arcWidth/4; origin.y: arcWidth/4; angle: time.second*6 + 180 } 
    }

    Rectangle {
        x: -arcWidth/2
        y: -arcWidth/2
        width: arcWidth
        height: arcWidth
        radius: 180
        color: settings.accent
    }
}