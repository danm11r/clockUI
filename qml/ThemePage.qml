// DM Jan 2024
// 
// Updated to seperate theme page

import QtQuick

Item {

    id: settingsPage
    
    height: clockRadius*2
    width: clockRadius*2

    property int arcWidth: clockRadius*(0.03)
    property int buttonSize: clockRadius*(0.3)
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
        text: "Color Theme"
        font.pixelSize: clockRadius*(0.15)
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

                x: clockRadius*(0.4)
                y: clockRadius-buttonSize/2
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
                    radius: 80
                }

                Rectangle {
                    id: rect2
                    y: buttonSize/2
                    width: buttonSize; height: 0
                    color: color1Array[index]
                    radius: 30
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
                        PropertyChanges { target: rect2; height: buttonSize/2; y: -buttonSize/2; radius: 0 }
                        PropertyChanges { target: rect3; radius: 0 }
                        PropertyChanges { target: rect4; height: buttonSize/2; y: buttonSize}
                        PropertyChanges { target: rect5; y: buttonSize; }
                    }
                ]

                transitions: Transition {
                    NumberAnimation { target: rect1; property: "y"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect2; property: "height"; easing.type: Easing.InOutQuad; duration: animationDelay }
                    NumberAnimation { target: rect2; property: "radius"; easing.type: Easing.InOutQuad; duration: animationDelay }
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