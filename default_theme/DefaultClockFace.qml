// Daniel Miller Jan 2024
// clockUI
// 
// This represents the clock face. Widgets are placed and positioned within 

import QtQuick 2.15

Item {

    property int arcWidth: clockRadius*(1/30)
    property int arcGap: clockRadius*(1/60)
    property int textSize: clockRadius*(2/9)
    property int widgetRadius: clockRadius*(19/54)

    BorderWidget {}
    WeatherWidget { x: clockRadius*(67/108); y: clockRadius*(67/108) } 
    TimeWidget { x: clockRadius*(149/108); y: clockRadius*(67/108) }
    DateWidget { x: clockRadius*(149/108); y: clockRadius*(149/108) }
    ClockWidget { x: clockRadius*(67/108); y: clockRadius*(149/108) }

}