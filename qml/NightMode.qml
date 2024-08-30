// DM Feb 2024

// Simple night mode theme

import QtQuick 2.15

Item {

    id: nightMode

    height: clockRadius*2
    width: clockRadius*2
    
    property string nightColor: "#CE2029"
    property int textSize: clockRadius*(5/9)

    // Time and PM display
    Row {

        id: text

        anchors.centerIn: parent

        Text {
            text: time.hour_text
            font.pixelSize: textSize
            color: nightColor
        }

        // Colon between hour and minute flashes every half second
        Text {
            id: colon
            text: ":"
            font.pixelSize: textSize
            color: nightColor 

            states: [
                State {
                    name: "visible"
                    PropertyChanges { target: colon; color: "transparent" }
                }
            ]
        } 

        Text {
            id: test
            text: time.minute_text
            font.pixelSize: textSize
            color: nightColor 
        } 

        // PM visibility changes depending on bool value 
        Text {
            visible: time.PM
            anchors.verticalCenter: colon.verticalCenter
            text: "PM"
            font.pixelSize: textSize*(1/3)
            color: nightColor 
        }  

    }

    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
            colon.state == 'visible' ? colon.state = "" : colon.state = 'visible';
        }
    }

    // Date text
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: text.bottom
        text: currDate.day.toUpperCase() + " " + currDate.date
        font.pixelSize: textSize*(1/2)
        color: nightColor 
    }

    // Weather text. Error icon will display instead if issue
    Text {
        id: weatherText
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: text.top
        text: currTemp.temp + "\u00B0"
        font.pixelSize: textSize*(1/2)
        color: nightColor 
    } 

    ErrorIcon {
        id: errorIcon
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: text.top
        width: textSize*(1/2)
        height: textSize*(1/2)

        MouseArea {
            anchors.fill: parent
            onClicked: errorMsg.open()
        }
    }

    states: [
        State {
            name: "error"
            PropertyChanges { target: weatherText; visible: false }
            PropertyChanges { target: errorIcon; visible: true }
        }
    ]

    Connections {
        target: backend
        
        function onTemp() {

            // Determine the error state 
            if (currTemp.tempErr == 0) {
                nightMode.state = ""
            }
            else {
                nightMode.state = "error"
            }
        }
    }
}