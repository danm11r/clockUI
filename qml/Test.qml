// DM June 2024

import QtQuick
import QtQuick.Shapes

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

    CustomSwitch{ x: 140; y: 240; height: 100; width: 200; disabled: true}
    CustomSwitch{ x: 140; y: 440; height: 100; width: 200; disabled: true; state: 'clicked'}
    CustomSwitch{ x: 140; y: 640; height: 100; width: 200 }
    CustomSwitch{ x: 140; y: 840; height: 200; width: 400; disabled: true}

}
