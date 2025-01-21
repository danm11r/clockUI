// DM June 2024
// Simple toggle switch

import QtQuick 2.15
import QtQuick.Shapes 1.15
import QtGraphicalEffects 1.15

Item {

    id: customSwitch

    Rectangle {
        id: background

        anchors.fill: parent
        color: settings.color3
        radius: 180
    }

    // Hazard stripe background for deactivated button
    Item {
        id: hazardStripe

        anchors.fill: background
        visible: false

        Item {

            anchors.fill: parent

            Repeater {

                model: 3

                Rectangle {
                    x: index*parent.width*.4
                    y: -parent.height/2

                    height: parent.height*2
                    width: parent.width*.2
                    color: settings.color2
                }
            }

            //transform: Rotation { origin.x: 0; origin.y: 0; angle: 45 } 
            transform: Rotation { origin.x: width/2; origin.y: height/2; angle: 45 } 
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: background
        }
    }

    Rectangle {

        visible: true

        id: circle
        color: settings.color1
        border.color: "white"
        border.width: parent.width*(.05)
        height: parent.height
        width: parent.width*(.5)                    
        radius: 180

    }

    MouseArea {
        enabled: (parent.state == 'disabled') ? false : true
        anchors.fill: parent
        onClicked: { 
            customSwitch.state == 'clicked' ? customSwitch.state = "" : customSwitch.state = 'clicked';
        }
    }

    states: [
        State {
            name: "clicked"
            PropertyChanges { target: circle; x: parent.width*(.5) }
            //PropertyChanges { target: circle; color: settings.color1 } removed because current implimentation does not have set on and off positions
        },
        State {
            name: "disabled"
            PropertyChanges { target: circle; border.color: "#B4B4B4" }
            PropertyChanges { target: circle; color: settings.color3 }
            PropertyChanges { target: hazardStripe; visible: true }
        }
    ]

    transitions: Transition {
        NumberAnimation { target: circle; property: "x"; duration: animationDelay }
        ColorAnimation { target: circle; property: "color"; duration: animationDelay }
    }
}