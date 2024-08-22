// DM Feb 2024

// Simple night mode theme

import QtQuick 2.15

Item {

    id: nightMode

    width: 1080
    height: 1080
    
    property string nightColor: "#CE2029"
    property int textSize: 300

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
            font.pixelSize: 100
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
        font.pixelSize: 150
        color: nightColor 
    }

    // Weather text. Error icon will display instead if issue
    Text {
        id: weatherText
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: text.top
        text: currTemp.temp + "\u00B0"
        font.pixelSize: 150
        color: nightColor 
    } 

    ErrorIcon {
        id: errorIcon
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: text.top
        width: 150
        height: 150

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

    Component.onCompleted: {
        if (currTemp.tempErr == 0) {
            nightMode.state = ""
        }
        else {
            nightMode.state = "error"
        }
    }

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