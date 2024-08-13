// DM Feb 2024
// clockUI
// 
// Analog clock face

import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {

    width: 1080
    height: 1080

    property int arcWidth: 18     
    property int arcGap: 9
    property int widgetRadius: 160

    // Date widget that moves if clock hands overlap 
    Item {
        id: date

        x: 540
        y: 750

        DateWidget{}

        states: [
            State {
                name: "moved"
                PropertyChanges {target: date; x: 750; y: 540}
            }
        ]
    }


    // Date widget that moves if clock hands overlap 
    Item {
        id: weather

        x: 540
        y: 330

        WeatherWidget{}

        states: [
            State {
                name: "moved"
                PropertyChanges {target: weather; x: 330; y: 540}
            }
        ]
    }

    AnalogClock{ x: 0; y: 0 }

    // Change the state of the date and weather widgets if the clock or minute hands overlap
    Connections {
        target: backend

        function onTime() {
            if ((time.hour >= 4 && time.hour <= 8) || time.hour >= 10 || time.hour <= 2) {
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

