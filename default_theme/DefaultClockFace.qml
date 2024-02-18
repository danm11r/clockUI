// Daniel Miller Jan 2024
// QtClock
// 
// This represents the clock face. Widgets are placed and positioned within 

import QtQuick 2.15

Item {

    property int bezelBorder: 10
    property int arcWidth: 18     
    property int arcGap: 9
    property int textSize: 120           
    property int widgetRadius: 190    

    BorderWidget { x: 0; y: 0 }
    WeatherWidget { x: -200; y: -200 } 
    TimeWidget { x: 200; y: -200 }
    DateWidget { x: 200; y: 200 }
    ClockWidget { x: -200; y: 200 }

}