// DM Feb 2024
// QtClock
// 
// This represents the clock face. Widgets are placed and positioned within 

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    property int arcWidth: 18     
    property int arcGap: 9
    property int textSize: 120           
    property int widgetRadius: 160

    WeatherWidget { x: 540; y: 330 }
    DateWidget{ x: 540; y: 750 }
    AnalogClock{ x: 0; y: 0 }

}
