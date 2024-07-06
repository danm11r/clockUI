// DM June 2024

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
    
    width: 1080
    height: 1080
    
    // Perimeter color
    Shape {

        ShapePath {
            fillColor: "transparent"
            strokeColor: settings.color1
            strokeWidth: arcWidth

            PathAngleArc {
                centerX: clockRadius; centerY: clockRadius
                radiusX: clockRadius - arcWidth/2; radiusY: clockRadius - arcWidth/2;
                startAngle: 0
                sweepAngle: 360
            }
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
        text: "Testing Area..."
        font.pixelSize: 80
        color: "white"   
    }  

    ErrorIcon{ x: 540; y: 540; height: 100; width: 100 }
    ErrorIcon{ x: 650; y: 540; height: 200; width: 200 }

    CustomButton{ x: 140; y: 540; height: 100; width: 200 }
    CustomButton{ x: 140; y: 640; height: 200; width: 400 }

}
