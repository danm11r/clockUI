// Daniel Miller Jan 2024
// QtClock
// main.py stores global properties and imports clockfaces

import Qt.labs.settings 1.0
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

// Import theme directory for clock face and widgets
import "./qml"
import "./analog_theme"
import "./default_theme"
import "./simple_theme"

ApplicationWindow {
    id: main
    visible: true
    width: 1080
    height: 1080

    title: "clockUI"
    color: "black"

    // Signals...
    property QtObject backend
    property var time: {'hour': 0, 'minute': 0, 'second': 0, 'hour_text': "0", 'minute_text': "0", 'PM': false } // This shares the same name as the signal and should probably be changed to something else
    property var currDate: {'day': "-", 'date': 0, 'totalDays': 0 }
    property var currTemp: {'temp': 0, 'tempL': 0, 'tempH': 0, 'tempErr': 0 }
    
    // General clock face settings
    property int clockRadius: 540
    property int arcWidth: 18
    property int animationDelay: 200

    // Color themes
    property variant color1Array: ["#50C878", "#15F4EE", "#F21894", "#A817E6"]//"#E6B217"] // 90%
    property variant color2Array: ["#3C965A", "#11BFB9", "#BF1375", "#8C13BF"]//, "#BF9413"] // 75%
    property variant color3Array: ["#29663D", "#0E9994", "#990F5D", "#700F99"]//, "#99770F"] // 60%
    property variant color4Array: ["#112919", "#042928", "#33051F", "#250533"]//, "#332805"] // 20%

    Settings {
        id: settings

        // Global color values. Overridden when theme selected from settings page
        property string color1: "#50C878"
        property string color2: "#3C965A"
        property string color3: "#29663D"
        property string color4: "#112919"
        property string accent: "#CE2029"
        property string bgcolor: "#2A2A2A"   
        property int selectedThemeIndex: 0
    }

    // Error message properties. The error message will eventually be moved to its own qml file
    property bool showError: true
    property string errorText: ""

    SwipeView {
        id: view

        width: clockRadius*2
        height: clockRadius*2
        
        currentIndex: 2

        Loader {
            active: SwipeView.isCurrentItem
            sourceComponent: NightMode {}
        }

        Loader {
            active: SwipeView.isCurrentItem
            sourceComponent: SimpleClockFace{}
        }

        Loader {
            active: SwipeView.isCurrentItem
            sourceComponent: AnalogClockFace {}
        }

        Loader {
            active: SwipeView.isCurrentItem
            sourceComponent: DefaultClockFace{}
        }

        Loader {    
            active: SwipeView.isCurrentItem        
            sourceComponent: SettingsPage {}
        }
    }

    Text {
        visible: false
        anchors {
            bottom: parent.bottom
            bottomMargin: 12
            right: parent.right
            rightMargin: 12
        }
        text: "DEMO" 
        font.pixelSize: 48
        color: "white"
    }

    Text {
        visible: false
        anchors {
            top: parent.top
            topMargin: 12
            right: parent.right
            rightMargin: 12
        }
        text: time.hour + ":" + time.minute + ":" + time.second
        font.pixelSize: 48
        color: "white"
    }

    // The following code for the dialog box should eventually be moved elsewhere... 
    // Weather api error dialog 
    Dialog {
        id: errorMsg

        anchors.centerIn: parent
        height: 540
        width: 540

        header: ToolBar {
            Rectangle {
                y: 50
                height: 50
                width: 540
                color: settings.color2
            }
            Label {
                text: "Weather Error"
                color: "white"
                font.pixelSize: 54
                anchors.centerIn: parent
            }
            background: Rectangle {

                implicitHeight: 100
                color: settings.color2
                radius: 90
            }
        }

        background: Rectangle {
            color: "#2A2A2A"
            border.color: settings.color2
            border.width: arcWidth
            radius: 45
        }

        contentItem: Text {
            width: 540
            wrapMode: Text.WordWrap
            text: errorText
            font.pixelSize: 48
            color: "white"
            leftPadding: 24
            horizontalAlignment: Text.AlignHCenter
        }

        Row {

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 24

            spacing: 20

            Button {

                contentItem: Text {
                    text: "Accept"
                    font.pixelSize: 48
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                background: Rectangle {
                    implicitHeight: 100
                    implicitWidth: 200
                    color: settings.color2
                    radius: 45
                }

                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                onClicked: errorMsg.accept()
            }

            Button {
                contentItem: Text {
                    text: "Retry"
                    font.pixelSize: 48
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                background: Rectangle {
                    implicitHeight: 100
                    implicitWidth: 200
                    color: settings.color2
                    radius: 45
                }

                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                onClicked: {
                    backend.update_temp()
                    errorMsg.accept()
                }
            }
        }
    }

    Connections {
        target: backend

        function onTime (hour, minute, second, hour_text, minute_text, PM) {
            time = {'hour': hour, 'minute': minute, 'second': second, 'hour_text': hour_text, 'minute_text': minute_text, 'PM': PM}
        }

        function onDate (day, date, totalDays) {
            currDate = {'day': day, 'date': date, 'totalDays': totalDays}
        }

        function onTemp(temp, tempL, tempH, tempErr) {
            currTemp = {'temp': temp, 'tempL': tempL, 'tempH': tempH, 'tempErr': tempErr}

            // Only show the error message once upon API error instead of each time an API call is attempted
            if (showError) {
                if (tempErr == '1')
                {
                    errorText = "Unable to fetch weather data.\nCheck API key!"
                    errorMsg.open()
                    showError = false
                }
                else if (tempErr == '2')
                {
                    errorText = "Unable to fetch weather data.\nCheck network connection!"
                    errorMsg.open()
                    showError = false
                }
                else if (tempErr == '3')
                {
                    errorText = "Unable to fetch weather data.\nCheck .env file!"
                    errorMsg.open()
                    showError = false
                }
                else {
                    showError: true
                }
            }

            // Close out any open error messages once connection resumed
            if (tempErr == '0')
            {
                errorMsg.close()
            }
        }   
    }
}