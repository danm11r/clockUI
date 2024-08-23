// DM Jan 2024
// 
// settings page currently only allows changing color scheme

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
    
    anchors.fill: parent

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
        text: "settings"
        font.pixelSize: clockRadius*(4/27)
        color: "white"   
    }  

    // Use repeater to create theme color selection buttons
    Row {

        anchors.horizontalCenter: parent.horizontalCenter

        spacing: buttonGap

        Repeater{

            id: colorButtonRepeater
            model: color1Array.length

            Item {

                id: colorButton

                x: clockRadius*(10/27)
                y: clockRadius-clockRadius*(5/27)
                state: (settings.selectedThemeIndex == index) ? 'clicked' : '' // Set button for selected theme to clicked state

                width: buttonSize
                height: buttonSize

                // When a button is selected reset all other buttons 
                function resetButtons() {
                    for (var i = 0; i < color1Array.length; i++) {
                        if (i != index) {
                            colorButtonRepeater.itemAt(i).state = 'unclicked'
                        }
                    }
                }

                Rectangle {
                    id: rect5
                    width: buttonSize; height: buttonSize
                    color: color3Array[index]
                    radius: 180
                }


                Rectangle {
                    id: rect4
                    y: buttonSize/2
                    width: buttonSize; height: 0
                    color: color3Array[index]
                }


                Rectangle {
                    id: rect3
                    width: buttonSize; height: buttonSize
                    color: color2Array[index]
                    radius: 180
                }

                Rectangle {
                    id: rect2
                    y: buttonSize/2
                    width: buttonSize; height: 0
                    color: color1Array[index]
                }

                Rectangle {
                    id: rect1
                    width: buttonSize; height: buttonSize
                    color: color1Array[index]
                    radius: 180
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { 
                        colorButton.state = 'clicked'
                        resetButtons()
                        settings.selectedThemeIndex = index
                        settings.color1 = color1Array[index]
                        settings.color2 = color2Array[index]
                        settings.color3 = color3Array[index]
                        settings.color4 = color4Array[index]
                    }
                }

                states: [
                    State {
                        name: "clicked"
                        PropertyChanges { target: rect1; y: -buttonSize }
                        PropertyChanges { target: rect2; height: buttonSize/2; y: -buttonSize/2}
                        PropertyChanges { target: rect3; radius: 0 }
                        PropertyChanges { target: rect4; height: buttonSize/2; y: buttonSize}
                        PropertyChanges { target: rect5; y: buttonSize; }
                    }
                ]

                transitions: Transition {
                    NumberAnimation { target: rect1; property: "y"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect2; property: "height"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect2; property: "y"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect3; property: "radius"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect4; property: "height"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect4; property: "y"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect5; property: "y"; easing.type: Easing.InOutQuad; duration: animationDelay }
                }
            }
        }
    }
}
