// DM Feb 2024

// Simple night mode theme

import QtQuick 2.15

Item {

    id: nightMode

    width: clockRadius*2
    height: clockRadius*2

    property string nightColor: "#CE2029"
    property int textSize: 300

    Row {

        id: text

        anchors.centerIn: parent

        Text {
            text: currTime.hour
            font.pixelSize: textSize
            color: nightColor 
        }  

        Text {
            id: timeColon
            text: ":"
            font.pixelSize: textSize
            color: nightColor 

            states: [
                State {
                    name: "visible"
                    PropertyChanges { target: timeColon; color: "transparent" }
                }
            ]
        } 

        Text {
            id: timeMin
            text: currTime.min
            font.pixelSize: textSize
            color: nightColor 
        } 

        Text {
            visible: currTime.PM
            anchors.verticalCenter: timeColon.verticalCenter
            text: "PM"
            font.pixelSize: 100
            color: nightColor 
        }  
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: text.bottom
        text: currDate.day + " " + currDate.date
        font.pixelSize: 150
        color: nightColor 
    } 

    Text {
        id: weatherText
        visible: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: text.top
        text: currTemp.temp
        font.pixelSize: 150
        color: nightColor 
    } 

    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
            timeColon.state == 'visible' ? timeColon.state = "" : timeColon.state = 'visible';
        }
    }

    states: [
        State {
            name: "error"
            PropertyChanges { target: weatherText; visible: false }
        }
    ]

    Connections {
        target: backend
        
        function onTemp(temp, tempL, tempH, tempPos, tempErr) {
            currTemp = {'temp': temp, 'tempL': tempL, 'tempH': tempH,'tempPos': tempPos, 'tempErr': tempErr}
            
            // Determine the error state 
            if (currTemp.tempErr == 0) {
                nightMode.state = ""
            }
            else if (currTemp.tempErr == 1 || currTemp.tempErr == 2) {
                nightMode.state = "error"
            }
        }
    }
}