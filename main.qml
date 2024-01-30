// Daniel Miller Jan 2024
// QtClock
// main.py stores global properties and imports the clockface

import QtQuick 2.15
import QtQuick.Controls 2.15

import "./default_theme" // Import theme directory for clock face and widgets

ApplicationWindow {
    id: main
    visible: true
    width: 1080     // UI designed for a 1080x1080 pixel display
    height: 1080
    
    title: "Clock"

    property QtObject backend

    // Widget properties and default values
    property var currTime: {'time': "00:00", 'PM': false }
    property var currDate: {'day': "NULL", 'date': "NULL", 'datePos': 0 }
    property var currTemp: {'temp': "0", 'tempL': "0", 'tempH': "0", 'tempPos': 0, 'tempLPos': 0, 'tempHPos': 0}
    property var hms: {'hour': 0, 'min': 0, 'sec': 0 }

    // Set the center of the clockface. Value can be adjusted as needed to compensate for display aspect ratio
    property int mainHCenter: main.width/2
    property int mainVCenter: main.height/2

    // Some values below are hardcoded but will soon be determined from display size
    property int bezelBorder: 10       // How far UI elements should be from physical edge of screen 
    property int arcWidth: width/60        
    property int arcGap: width/120   
    property int textSize: 120           
    property int widgetRadius: 190        

    // Global color values. ALL widgets should get colors from here for consistancy
    property string primary: "#50C878"
    property string secondary: "#3C965A"
    property string tertiary: "#29663D"
    property string bgcolor: "#2A2A2A"

    // Place a clockface in the window
    ClockFace {}    

    Connections {
        target: backend

        function onTime(time, PM) {
            currTime = {'time': time, 'PM': PM};
        }

        function onDate(day, date, datePos) {
            currDate = {'day': day, 'date': date, 'datePos': datePos};
        }

        function onTemp(temp, tempL, tempH, tempPos) {
            currTemp = {'temp': temp, 'tempL': tempL, 'tempH': tempH,'tempPos': tempPos}
        }

        function onHms(hour, minute, second) {
            hms = {'hour': hour, 'min': minute, 'sec': second}
        }
    }
}