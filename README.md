# QtClock
Smart clock UI for the Raspberry Pi built with Python and QtQuick

# About 
This app is based on QML using the PyQt5 toolkit. It is intended to run on a Raspberry Pi connected to a round 1080x1080 LCD display. 

The current version is only a proof of concept, but feel free to give it a try! I've created a default theme that displays the time, date, and temperature. Take a look:
![clockdemo](https://github.com/danm11r/QtClock/assets/148667664/28a02fce-975e-44b0-a811-4645f9ff6266)

# Installation 

A detailed guide on installing this app on the Raspberri Pi is coming soon. In the meantime, you can easily get the app running on a Linux machine by installing the python modules listed in `requirements.txt`.

Also note that for live temperature data, you need to provide an OpenWeather API key (which you can get for free). Add your API key and zip code to the `weather.py` file; otherwise, only placeholder values will be shown. 

