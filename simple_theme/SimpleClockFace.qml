// DM July 2024
// clockUI
// 
// Simple clock face

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    id: analogClock

    width: 1080
    height: 1080

    property string hour
    property string minute
    property int textSize: 200
    property int clockRadius: height/2

    property int arcWidth: 24

    // Draw background gradient
    Shape {

        x: parent.height/2
        y: parent.height/2

        ShapePath {

            strokeColor: "transparent"   
            strokeWidth: 6

            fillGradient: RadialGradient {
                centerX: 0; centerY: 0
                centerRadius: clockRadius
                focalX: centerX; focalY: centerY
                GradientStop { position: 0.6; color: "black" }
                GradientStop { position: 0.95; color: settings.color4 }
                GradientStop { position: 1.5; color: "black" }
            }

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: clockRadius; radiusY: clockRadius;
                startAngle: 0
                sweepAngle: 360
            }
        } 
    }

    // Time and date text
    Column {

        anchors.centerIn: parent
        spacing: -30
        
        Text {
            id: timeText
            text: time.hour_text + ":" + time.minute_text
            font.pixelSize: textSize
            font.bold: true
            color: "white"
        }

        Row {

            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: currDate.day.toUpperCase() + " "
                font.pixelSize: 140
                font.bold: true
                color: settings.color3
            }


            Text {
                text: currDate.date
                font.pixelSize: 140
                color: settings.color1
            }
        }
    }

    // Clock border
    Item {

        anchors.fill: parent

        // border
        Repeater {

            model: 60

            Rectangle {
                x: clockRadius - arcWidth/4
                y: 0
                width: arcWidth/2
                height: arcWidth
                radius: 180
                color: "#B4B4B4"
                transform: Rotation { origin.x: arcWidth/4; origin.y: clockRadius; angle: index*6 } 
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
                color: (time.hour == index) ? settings.color2 : "white"
                transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius; angle: index*30 } 
            }
        }

        // hour text
        Repeater {

            model: 12

            Item {
                x: parent.height/2 + Math.round(clockRadius*0.81*Math.cos((index*30-60)* Math.PI / 180))
                y: parent.height/2 + Math.round(clockRadius*0.81*Math.sin((index*30-60)* Math.PI / 180))
                
                Text {
                    anchors.centerIn: parent
                    text: index+1
                    font.pixelSize: clockRadius*(1/6)
                    font.bold: true
                    color: (time.hour-1 == index) ? settings.color2 : "white"
                }
            }
        }
    }

    // Minute hand
    Rectangle {
        x: clockRadius - arcWidth/2
        y: 0
        width: arcWidth
        height: arcWidth*6
        radius: 180
        color: settings.color1
        transform: Rotation { origin.x: arcWidth/2; origin.y: clockRadius; angle: time.minute*6} 
    }

    // Second hand
    Rectangle {
        x: clockRadius - arcWidth/4
        y: 0
        width: arcWidth/2
        height: arcWidth*8
        radius: 180
        color: settings.accent
        transform: Rotation { origin.x: arcWidth/4; origin.y: clockRadius; angle: time.second*6} 
    }
}
