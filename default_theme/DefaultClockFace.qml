// Daniel Miller Jan 2024
// clockUI
// 
// This represents the clock face. Widgets are placed and positioned within 

import QtQuick 2.15

Item {

    property int arcWidth: 18     
    property int arcGap: 9
    property int textSize: 120           
    property int widgetRadius: 190    

    BorderWidget {}
    WeatherWidget { x: 335; y: 335 } 
    TimeWidget { x: 745; y: 335 }
    DateWidget { x: 745; y: 745 }
    ClockWidget { x: 335; y: 745 }

}