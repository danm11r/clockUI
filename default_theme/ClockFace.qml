// Daniel Miller Jan 2024
// QtClock
// 
// This represents the clock face. Widgets are placed and positioned within 

import QtQuick 2.15

Rectangle {
    anchors.fill: parent
    color: "black"

    BorderWidget {}
    WeatherWidget { x: 340; y: 340 } // 153, 327
    TimeWidget { x: 740; y: 340 }
    DateWidget { x: 740; y: 740 }
    ClockWidget { x: 340; y: 740 }

}