// DM Feb 2024
// clockUI

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    anchors.fill: parent
    property int textSize: clockRadius*(5/27)

    // border
    Repeater {

        model: 60

        Rectangle {
            x: clockRadius - arcWidth/2
            y: 0
            width: arcWidth
            height: arcWidth
            radius: 180
            color: "#B4B4B4"
            transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius; angle: index*6 } 
        }
    }

    // hour marks
    Repeater {

        model: 12

        Rectangle {
            x: clockRadius - arcWidth/2
            y: 0
            width: arcWidth
            height: arcWidth*2
            radius: 180
            color: "white"
            transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius; angle: index*30 } 
        }
    }

    // hour text
    Repeater {

        model: 12

        Item {
            x: parent.height/2 + Math.round(clockRadius*(22/27)*Math.cos((index*30-60)* Math.PI / 180))
            y: parent.height/2 + Math.round(clockRadius*(22/27)*Math.sin((index*30-60)* Math.PI / 180))
            
            Text {
                anchors.centerIn: parent
                text: index+1
                font.pixelSize: textSize
                color: "white"
            }
        }
    }

    // minute hand
    Rectangle {
        x: clockRadius-arcWidth/4
        y: clockRadius-arcWidth/4
        width: arcWidth/2
        height: clockRadius*(5/27)
        radius: 180
        color: settings.color1

        transform: Rotation { origin.x: arcWidth/4; origin.y: arcWidth/4; angle: time.minute*6 + 180 } 
    }

    Rectangle {
        x: clockRadius-arcWidth
        y: clockRadius-arcWidth + clockRadius*(5/27)
        width: arcWidth*2
        height: clockRadius-clockRadius*(2/9)
        radius: 180
        color: settings.color1

        transform: Rotation { origin.x: arcWidth; origin.y: arcWidth-clockRadius*(5/27); angle: time.minute*6 + 180 } 
    }

    // hour hand
    Rectangle {
        x: clockRadius-arcWidth
        y: clockRadius-arcWidth + clockRadius*(5/27)
        width: arcWidth*2
        height: clockRadius-clockRadius*(11/18)
        radius: 180
        color: settings.color2

        transform: Rotation { origin.x: arcWidth; origin.y: arcWidth-clockRadius*(5/27); angle: time.hour*30 + 180 + time.minute*(1/2) } 
    }

    Rectangle {
        x: clockRadius-arcWidth/4
        y: clockRadius-arcWidth/4
        width: arcWidth/2
        height: clockRadius*(5/27)
        radius: 180
        color: settings.color2

        transform: Rotation { origin.x: arcWidth/4; origin.y: arcWidth/4; angle: time.hour*30 + 180 + time.minute*(1/2) } 
    }

    // second hand
    Rectangle {
        x: clockRadius-arcWidth/4
        y: clockRadius-arcWidth/4
        width: arcWidth/2
        height: clockRadius
        radius: 180
        color: settings.accent

        transform: Rotation { origin.x: arcWidth/4; origin.y: arcWidth/4; angle: time.second*6 + 180 } 
    }

    Shape {
        ShapePath {
            fillColor: settings.accent
            strokeColor: settings.accent   
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: clockRadius; centerY: clockRadius
                radiusX: arcWidth*(2/9); radiusY: arcWidth*(2/9);
                startAngle: 0
                sweepAngle: 360
            }
        } 
    }
}
