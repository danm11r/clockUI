// Daniel Miller Jan 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    // Draw background circle
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
           
    // Draw temp guage
    Shape {
        ShapePath {
            fillColor: "transparent"
            strokeColor: primary
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 90
                sweepAngle: currTemp.tempPos

                Behavior on sweepAngle {
                    SmoothedAnimation { 
                        velocity: 30 
                        duration: 250
                    }
                } 
            }                

            PathAngleArc {
                centerX: 0; centerY: 0
                radiusX: widgetRadius - arcWidth/2; radiusY: widgetRadius - arcWidth/2;
                startAngle: 90 
                sweepAngle: -currTemp.tempPos

                Behavior on sweepAngle {
                    SmoothedAnimation { 
                        velocity: 10 
                        duration: 250
                    }
                } 
            }      
        } 
    }

    // Text for current temp
    Text {
        anchors.centerIn: parent
        text: currTemp.temp
        font.pixelSize: textSize
        color: "white"   
    }  

    // Min temp 
    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 55
        anchors.leftMargin: -95
        text: currTemp.tempL
        font.pixelSize: textSize/2
        color: "white"   
    }  

    // Max temp
    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 55
        anchors.leftMargin: 25
        text: currTemp.tempH
        font.pixelSize: textSize/2
        color: "white"   
    } 

    // Draw divider
    Rectangle {
        x: - arcWidth/2
        y: 80
        width: arcWidth
        height: arcWidth*2
        radius: 180
        color: primary //"#CE2029"
    } 
}
