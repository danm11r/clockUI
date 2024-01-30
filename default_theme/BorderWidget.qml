// Daniel Miller Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    // Draw the second marks around clock circumference
    Repeater {

        model: 60

        Rectangle {
            x: mainHCenter - arcWidth/2
            y: bezelBorder
            width: arcWidth
            height: arcWidth
            radius: 180
            color: "#B4B4B4"

            transform: Rotation { origin.x: arcWidth/2; origin.y: mainVCenter - bezelBorder; angle: index*6 } 
        }
    }

    // Draw the hour marks
    Repeater {

        model: 12

        Rectangle {
            x: mainHCenter - arcWidth/2
            y: bezelBorder
            width: arcWidth
            height: arcWidth*2
            radius: 180
            color: "#B4B4B4"

            transform: Rotation { origin.x: arcWidth/2; origin.y: mainVCenter - bezelBorder; angle: index*30 } 
        }
    }

    // Hour arc
    Shape {

        ShapePath {
            fillColor: "transparent"
            strokeColor: tertiary //"#E650D4"
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: mainHCenter; centerY: mainVCenter
                radiusX: mainHCenter - bezelBorder - arcWidth/2; radiusY: mainVCenter - bezelBorder - arcWidth/2;
                startAngle: 255 //268
                sweepAngle: 30  //4
            }
        }

        transform: Rotation { 
            origin.x: mainHCenter
            origin.y: mainVCenter
            angle: (hms.hour+.5)*30
        }
    }

    // Hour arc edge pieces
    Rectangle {
        x: mainHCenter - arcWidth/2
        y: bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: tertiary

        transform: Rotation { origin.x: arcWidth/2; origin.y: mainVCenter - bezelBorder; angle: hms.hour*30 } 
    }

    Rectangle {
        x: mainHCenter - arcWidth/2
        y: bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: tertiary

        transform: Rotation { origin.x: arcWidth/2; origin.y: mainVCenter - bezelBorder; angle: (hms.hour+1)*30 } 
    }

    // Min arc
    Shape {

        ShapePath {
            fillColor: "transparent"
            strokeColor: secondary//"#FFFF03"
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: mainHCenter; centerY: mainVCenter
                radiusX: mainHCenter - bezelBorder - arcWidth/2; radiusY: mainVCenter - bezelBorder - arcWidth/2;
                startAngle: 267 //268
                sweepAngle: 6   //4
            }
        }

        transform: Rotation { 
            origin.x: mainHCenter
            origin.y: mainVCenter
            angle: (hms.min+.5)*6
        }
    }

    // Min arc edge pieces
    Rectangle {
        x: mainHCenter - arcWidth/2
        y: bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: secondary

        transform: Rotation { origin.x: arcWidth/2; origin.y: mainVCenter - bezelBorder; angle: hms.min*6 } 
    }

    Rectangle {
        x: mainHCenter - arcWidth/2
        y: bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: secondary

        transform: Rotation { origin.x: arcWidth/2; origin.y: mainVCenter - bezelBorder; angle: (hms.min+1)*6 } 
    }

    // Second mark
    Rectangle {
        x: mainHCenter - arcWidth/2
        y: bezelBorder
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: primary //"#00E6E6"

        transform: Rotation { origin.x: arcWidth/2; origin.y: mainVCenter - bezelBorder; angle: hms.sec*6 } 
    }
}