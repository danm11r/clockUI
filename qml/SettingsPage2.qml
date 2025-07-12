// DM July 2025
// 
// second settings page allows controlling brightness of connected DSI lcd
// this is temporary

import QtQuick 2.15
import QtQuick.Shapes 1.15
import QtQuick.Controls 2.15

Item {

    id: settingsPage2
    
    height: clockRadius*2
    width: clockRadius*2

    property int arcWidth: clockRadius*(1/30)
    
    property int buttonSize: clockRadius*(5/18)
    property int buttonGap: clockRadius*(5/54)

    // Draw background circle
    Shape {
        ShapePath {
            fillColor: "#2A2A2A"
            strokeColor: "#2A2A2A"   
            strokeWidth: arcWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: clockRadius; centerY: clockRadius
                radiusX: clockRadius - arcWidth/2; radiusY: clockRadius - arcWidth/2;
                startAngle: 0
                sweepAngle: 360
            }
        } 
    }

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
        anchors.topMargin: clockRadius*(5/27)
        text: "settings2"
        font.pixelSize: clockRadius*(4/27)
        color: "white"   
    }

    // Brightness slider copied from DashUI
    Row {

        anchors.horizontalCenter: parent.horizontalCenter
        y: 510

        BrightnessIcon { height: 75; width: 75 }

        // Brightness slider from 1 to 255
        Slider {

            id: control

            // With this step size we never quite reach the max brightness of 255
            stepSize: 10
            from: 1
            value: settings.currentBrightness
            to: 255

            leftPadding: 25

            background: Rectangle {
                x: control.leftPadding
                y:  control.availableHeight / 2 - height / 2
                implicitWidth: 400
                implicitHeight: 25
                width: control.availableWidth
                height: implicitHeight
                radius: 180
                color: "#bdbebf"

                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    color: settings.color2
                    radius: 180
                }
            }
            
            handle: Rectangle {
                x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                y: control.availableHeight / 2 - height / 2
                implicitWidth: 75
                implicitHeight: 75
                radius: width/2
                color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }

            // Only update when slider is clicked or released because brightness updates are too slow for continuous updating
            // The above comment was relevant for DashUI but probably not the case for ClockUI as brightness is changed differently
            onPressedChanged: {
                backend.update_brightness(value)
                settings.currentBrightness = value
            }
        }
    }
}