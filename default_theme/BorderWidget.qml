// DM Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    // Draw the second marks around clock circumference
    Repeater {

        model: 60

        Rectangle {
            x: - arcWidth/2
            y: - clockRadius + bezelBorder
            width: arcWidth
            height: arcWidth
            radius: 180
            color: "#B4B4B4"

            transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius - bezelBorder; angle: index*6 } 
        }
    }

    // Draw the hour marks
    Repeater {

        model: 12

        Rectangle {
            x: - arcWidth/2
            y: - clockRadius + bezelBorder
            width: arcWidth
            height: arcWidth*2
            radius: 180
            color: "#B4B4B4"

            transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius - bezelBorder; angle: index*30 } 
        }
    }

    // Hour arc
    Shape {

        ShapePath {
            fillColor: "transparent"
            strokeColor: color3
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: clockRadius - bezelBorder - arcWidth/2; radiusY: clockRadius - bezelBorder - arcWidth/2;
                startAngle: 255 //268
                sweepAngle: 30  //4
            }
        }

        transform: Rotation { origin.x: 0; origin.y: 0; angle: (hms.hour+.5)*30 }
    }

    // Hour arc edge pieces
    Rectangle {
        x: - arcWidth/2
        y: - clockRadius + bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: color3

        transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius - bezelBorder; angle: hms.hour*30 } 
    }

    Rectangle {
        x: - arcWidth/2
        y: - clockRadius + bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: color3

        transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius - bezelBorder; angle: (hms.hour+1)*30 } 
    }

    // Min arc
    Shape {

        ShapePath {
            fillColor: "transparent"
            strokeColor: color2
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: clockRadius - bezelBorder - arcWidth/2; radiusY: clockRadius - bezelBorder - arcWidth/2;
                startAngle: 267 //268
                sweepAngle: 6   //4
            }
        }

        transform: Rotation { origin.x: 0; origin.y: 0; angle: (hms.min+.5)*6 }
    }

    // Min arc edge pieces
    Rectangle {
        x: - arcWidth/2
        y: - clockRadius + bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: color2

        transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius - bezelBorder; angle: hms.min*6 } 
    }

    Rectangle {
        x: - arcWidth/2
        y: - clockRadius + bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: color2

        transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius - bezelBorder; angle: (hms.min+1)*6 } 
    }

    // Second mark
    Rectangle {
        x: - arcWidth/2
        y: - clockRadius + bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: color1

        transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius - bezelBorder; angle: hms.sec*6 } 
    }
}