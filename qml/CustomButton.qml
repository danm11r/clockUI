// DM June 2024
// Simple toggle button

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    id: customSwitch

    Rectangle {

        anchors.fill: parent
        color: settings.color4
        radius: 180

    }

    Rectangle {

        id: circle
        color: settings.color4
        border.color: "white"
        border.width: parent.width*(.05)
        height: parent.height
        width: parent.width*(.5)                         //"#CE2029"
        radius: 180

    }

    MouseArea {
        anchors.fill: parent
        onClicked: { 
            customSwitch.state == 'clicked' ? customSwitch.state = "" : customSwitch.state = 'clicked';
        }
    }

    states: [
        State {
            name: "clicked"
            PropertyChanges { target: circle; x: parent.width*(.5) }
            PropertyChanges { target: circle; color: settings.color1 }
        }
    ]

    transitions: Transition {
        NumberAnimation { target: circle; property: "x"; duration: animationDelay }
        ColorAnimation { target: circle; property: "color"; duration: animationDelay }
    }
}