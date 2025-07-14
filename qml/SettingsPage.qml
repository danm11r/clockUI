// DM July 2025
// 
// change screen brightness, toggle 12hr time, select temp units

import QtQuick
import QtQuick.Controls

Item {

    id: settingsPage
    
    height: clockRadius*2
    width: clockRadius*2

    property int arcWidth: clockRadius*(0.03)
    property int buttonSize: clockRadius*(0.2)
    property int buttonGap: clockRadius*(0.1)

    // Draw background circle
    Rectangle {
        height: clockRadius*2
        width: clockRadius*2
        color: settings.bgcolor
        radius: width/2

        border.width: arcWidth
        border.color: settings.color1
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: clockRadius*(0.2)
        text: "Settings"
        font.pixelSize: clockRadius*(0.15)
        color: "white"   
    }

    Column{

        anchors.centerIn: parent
        spacing: buttonGap

        // 12 or 24hr time select toggle
        // Update: layout changed so that the text and button are both anchored
        // to the center of the page and buttons will line up regardless of text size
        Item {
   
            anchors.horizontalCenter: parent.horizontalCenter
            height: buttonSize
            width: 1
            
            Text {
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: buttonGap*(0.5)

                text: (settings.time24hr == true) ? "24hr" : "12hr"
                font.pixelSize: clockRadius*(0.15)
                color: "white"   
            }  

            CustomSwitch { 
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: buttonGap*(0.5)

                width: buttonSize*2
                height: buttonSize
                state: (settings.time24hr == true) ? 'clicked' : ''

                onStateChanged: {
                    settings.time24hr = (state == 'clicked') ? true : false
                }
            }
        }

        // Fahrenheit or Celsius select toggle   
        Item {

            anchors.horizontalCenter: parent.horizontalCenter
            height: buttonSize
            width: 1

            Text {
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: buttonGap*(0.5)

                text: "\u00B0" + ((currTemp.metric == true) ? "C" : "F")
                font.pixelSize: clockRadius*(0.15)
                color: "white"   
            }  

            // Switch is locked during API call and disabled if API call fails
            CustomSwitch { 
                id: unitSwitch

                anchors.left: parent.horizontalCenter
                anchors.leftMargin: buttonGap*(0.5)

                width: buttonSize*2
                height: buttonSize

                onStateChanged: {
                    settingsPage.state = 'locked'
                    backend.update_units((state == 'clicked') ? true : false)
                }

                // Fix for binding loop on state property
                Binding on state {
                    value: (currTemp.metric == true) ? 'clicked' : ''
                    delayed: true
                }
            }
        }   

        // Brightness slider copied from DashUI
        Row {

            anchors.horizontalCenter: parent.horizontalCenter

            BrightnessIcon { height: buttonSize; width: buttonSize }

            // Brightness slider from 1 to 255
            Slider {

                id: control

                stepSize: 5
                from: 10
                value: settings.currentBrightness
                to: 255

                leftPadding: buttonGap

                background: Rectangle {
                    x: control.leftPadding
                    y:  control.availableHeight / 2 - height / 2
                    implicitWidth: 400
                    implicitHeight: clockRadius*(0.07)
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
                    implicitWidth: buttonSize
                    implicitHeight: buttonSize
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

    states: [
        State {
            name: "error"
            PropertyChanges { target: unitSwitch; disabled: true }
        },
        State {
            name: "locked"
            PropertyChanges { target: unitSwitch; locked: true }
        }
    ]

    Connections {
        target: backend
        
        function onTemp() {

            // Determine the error state 
            if (currTemp.tempErr == 0) {
                settingsPage.state = ''
            }
            else {
                settingsPage.state = 'error'
            }
        }
    }
}