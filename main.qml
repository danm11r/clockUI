// Daniel Miller Jan 2024
// QtClock
// main.py stores global properties and imports clockfaces

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

// Import theme directory for clock face and widgets
import "./default_theme" 
import "./analog_theme"

ApplicationWindow {
    id: main
    visible: true
    width: 1080     // UI designed for a 1080x1080 pixel display
    height: 1080
    
    title: "Clock"
    color: "black"

    property QtObject backend

    // Widget properties and default values
    property var currTime: {'hour': "00", 'min': "00", 'PM': false }
    property var currDate: {'day': "NULL", 'date': "0", 'datePos': 0 }
    property var currTemp: {'temp': "0", 'tempL': "0", 'tempH': "0", 'tempPos': 0, 'tempLPos': 0, 'tempHPos': 0, 'tempErr': 0 }
    property var hms: {'hour': 0, 'min': 0, 'sec': 0 }

    // Some values below are hardcoded but will soon be determined from display size 
    property int clockRadius: 540

    // Global color values. Overridden when theme selected from settings page
    property string color1: "#50C878"
    property string color2: "#3C965A"
    property string color3: "#29663D"
    property string color4: "#112919"
    property string accent: "#CE2029"
    property string bgcolor: "#2A2A2A"

    // Arrays store color theme values
    property variant color1Array: ["#50C878", "#15F4EE"]
    property variant color2Array: ["#3C965A", "#11BFB9"]
    property variant color3Array: ["#29663D", "#0E9994"]
    property variant color4Array: ["#112919", "#042928"]

    // Swipeview for multiple pages
    SwipeView {
        id: view

        currentIndex: 2
        anchors.fill: parent

        Item {
            id: firstPage

            NightMode {}
        }

        Item {
            id: secondPage
            
            DefaultClockFace { x: 540; y: 540 }
        }

        Item {
            id: thirdPage

            AnalogClockFace {}
        }

        Item {
            id: fourthPage
            
            SettingsPage {}
        }
    }

    Connections {
        target: backend

        function onTime(hour, min, PM) {
            currTime = {'hour': hour, 'min': min, 'PM': PM};
        }

        function onDate(day, date, datePos) {
            currDate = {'day': day, 'date': date, 'datePos': datePos};
        }

        function onHms(hour, minute, second) {
            hms = {'hour': hour, 'min': minute, 'sec': second}
        }
    }
}