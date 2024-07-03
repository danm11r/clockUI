// Daniel Miller Jan 2024
// clockUI
// 
// This represents the clock face. Widgets are placed and positioned within 

import QtQuick 2.15

Item {

    property int bezelBorder: 10
    property int arcWidth: 18     
    property int arcGap: 9
    property int textSize: 120           
    property int widgetRadius: 190    

    BorderWidget {}
    WeatherWidget { x: 340; y: 340 } 
    TimeWidget { x: 740; y: 340 }
    DateWidget { x: 740; y: 740 }
    ClockWidget { x: 340; y: 740 }

}