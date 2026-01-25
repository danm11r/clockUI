// DM Feb 2024
// clockUI
// 
// Analog clock face

import QtQuick

Item {

    height: clockRadius*2
    width: clockRadius*2

    property int arcWidth: clockRadius*(1/30)
    property int arcGap: clockRadius*(1/60)
    property int widgetRadius: clockRadius*(8/27)

    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    // Date widget that moves if clock hands overlap 
    Item {
        id: date

        x: clockRadius
        y: clockRadius*(25/18)

        DateWidget{}

        states: [
            State {
                name: "moved"
                PropertyChanges {target: date; x: clockRadius*(25/18); y: clockRadius}
            }
        ]
    }


    // Date widget that moves if clock hands overlap 
    Item {
        id: weather

        x: clockRadius
        y: clockRadius*(11/18)

        WeatherWidget{}

        states: [
            State {
                name: "moved"
                PropertyChanges {target: weather; x: clockRadius*(11/18); y: clockRadius}
            }
        ]
    }

    AnalogClock{ x: 0; y: 0 }

    // Change the state of the date and weather widgets if the clock or minute hands overlap
    Connections {
        target: backend

        function onTime() {
            if ((time.hour % 12 >= 4 && time.hour % 12 < 8) || (time.hour % 12 >= 10 && time.hour % 12 < 2)) {
                date.state = "moved"
                weather.state = "moved"
            }
            else {
                date.state = ""
                weather.state = ""
            }
        }
    }
}