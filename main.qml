// Daniel Miller Jan 2024
// ClockUI
// main.py stores global properties and imports clockfaces

import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects

// Import theme directory for clock face and widgets
import "./qml"
import "./analog_theme"
import "./default_theme"
import "./simple_theme"

ApplicationWindow {
    id: main
    visible: true
    width: 720
    height: 720

    title: "clockUI"
    color: "black"

    // Signals...
    property QtObject backend
    property var time: {'hour': 0, 'minute': 0, 'second': 0, 'hour_12_text': "0", 'hour_24_text': "0", 'minute_text': "0", 'PM': false } // This shares the same name as the signal and should probably be changed to something else
    property var currDate: {'day': "-", 'date': 0, 'totalDays': 0 }
    property var currTemp: {'temp': 0, 'tempL': 0, 'tempH': 0, 'metric': false, 'tempErr': 0 }
    
    // General clock face settings
    property int clockRadius: height/2
    property int animationDelay: 200
    property int arcWidth: clockRadius*(1/30)

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
        property int currentViewIndex: 0
        property bool time24hr: false
        property int currentBrightness: 0
    }

    // Error message properties. The error message will eventually be moved to its own qml file
    property bool showError: true
    property string errorText: ""
    property int errorTextSize: clockRadius*(4/45)

    SwipeView {
        id: view

        visible: true
        
        currentIndex: settings.currentViewIndex
        
        height: parent.height
        width: parent.width

        Item {
            NightMode {}
        }

        Item {
            SimpleClockFace{}
        }

        Item {
            AnalogClockFace {}
        }

        Item {
            DefaultClockFace{}
        }

        Item {            
            ThemePage {}
        }

        Item {            
            SettingsPage {}
        }

        onCurrentIndexChanged: {
            settings.currentViewIndex = currentIndex
        }
    }

    // Blur swipe view when error dialog is displayed
    Loader {
        anchors.fill: parent
        id: blurLoader
        active: false
        sourceComponent: Item {
            Rectangle {
                anchors.fill: fastBlur
                color: settings.bgcolor
            }

            FastBlur {
                id: fastBlur

                anchors.fill: parent

                source: view

                radius: 0
                opacity: 1

                NumberAnimation on radius { to: 32; duration: 250 }
                NumberAnimation on opacity { to: 0.6; duration: 250 }
            }
        }
    }

    // For debug only
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

    // Weather api error dialog 
    Dialog {
        id: errorMsg

        anchors.centerIn: parent
        height: clockRadius
        width: clockRadius

        header: ToolBar {

            // fix for qt6, header rectangle was misaligned - this wasn't an issue for qt5, did the default change?
            leftPadding: 0

            // Added rectangle to pad the header
            Rectangle {
                y: clockRadius*(0.1)
                height: clockRadius*(0.1)
                width: clockRadius
                color: settings.color2
            }
            Label {
                text: "Weather Error"
                color: "white"
                font.pixelSize: clockRadius*(0.1)
                anchors.centerIn: parent
            }
            background: Rectangle {

                implicitHeight: clockRadius*(0.2)
                color: settings.color2
                radius: clockRadius*(0.17)
            }
        }

        background: Rectangle {
            color: "#2A2A2A"
            border.color: settings.color2
            border.width: arcWidth
            radius: clockRadius*(0.1)
        }

        contentItem: Text {
            width: clockRadius
            wrapMode: Text.WordWrap
            text: errorText
            font.pixelSize: errorTextSize
            color: "white"
            leftPadding: clockRadius*(0.05)
            horizontalAlignment: Text.AlignHCenter
        }

        Row {

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: clockRadius*(0.05)

            spacing: clockRadius*(0.04)

            Button {

                contentItem: Text {
                    text: "Accept"
                    font.pixelSize: errorTextSize
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                background: Rectangle {
                    implicitHeight: clockRadius*(0.2)
                    implicitWidth: clockRadius*(0.4)
                    color: settings.color2
                    radius: clockRadius*(0.07)
                }

                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                onClicked: errorMsg.accept()
            }

            Button {
                contentItem: Text {
                    text: "Retry"
                    font.pixelSize: errorTextSize
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                background: Rectangle {
                    implicitHeight: clockRadius*(0.2)
                    implicitWidth: clockRadius*(0.4)
                    color: settings.color2
                    radius: clockRadius*(0.07)
                }

                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                onClicked: {
                    backend.update_temp()
                    errorMsg.accept()
                }
            }
        }
        
        onOpened: {
            blurLoader.active = true
        }  

        onClosed: {
            blurLoader.active = false
        }
    }

    Connections {
        target: backend

        function onTime (hour, minute, second, hour_12_text, hour_24_text, minute_text, PM) {
            time = {'hour': hour, 'minute': minute, 'second': second, 'hour_12_text': hour_12_text, 'hour_24_text': hour_24_text, 'minute_text': minute_text, 'PM': PM}
        }

        function onDate (day, date, totalDays) {
            currDate = {'day': day, 'date': date, 'totalDays': totalDays}
        }

        function onTemp(temp, tempL, tempH, metric, tempErr) {
            currTemp = {'temp': temp, 'tempL': tempL, 'tempH': tempH, 'metric': metric, 'tempErr': tempErr}

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