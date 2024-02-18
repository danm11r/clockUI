// DM Jan 2024
// 
// Settings page currently only allows changing color scheme

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
    
    width: clockRadius*2
    height: clockRadius*2

    property int arcWidth: 18     
    
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
            strokeColor: color1
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
        text: "Settings"
        font.pixelSize: 80
        color: "white"   
    }  

    // Use repeater to create theme color selection buttons. Color values are stored in arrays in main.qml
    Row {

        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 50

        Repeater{

            id: colorButtonRepeater
            model: color1Array.length

            Item {

                id: colorButton

                x: 200
                y: clockRadius

                width: 100
                height: 100

                // When a button is selected reset all other buttons 
                function resetButtons() {
                    for (var i = 0; i < color1Array.length; i++) {

                        if (i != index) {

                            colorButtonRepeater.itemAt(i).state = 'unclicked'
                        }
                    }
                }

                Rectangle {

                    id: rect3

                    width: 100; height: 100
                    
                    color: color3Array[index]
                }

                Rectangle {

                    id: rect2

                    width: 100; height: 100
                    
                    color: color2Array[index]
                }

                Rectangle {

                    id: rect1

                    width: 100; height: 100
                    
                    color: color1Array[index]
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: { 

                        colorButton.state == 'clicked' ? colorButton.state = "" : colorButton.state = 'clicked';
                        resetButtons()
                        color1 = color1Array[index]
                        color2 = color2Array[index]
                        color3 = color3Array[index]
                        color4 = color4Array[index]
                    }
                }

                states: [
                    State {
                        name: "clicked"
                        PropertyChanges { target: rect2; y: 100 }
                        PropertyChanges { target: rect3; y: 200 }
                    }
                ]

                transitions: Transition {
                    NumberAnimation { target: rect2; property: "y" }
                    NumberAnimation { target: rect3; property: "y" }
                }
            }
        }
    }
}
