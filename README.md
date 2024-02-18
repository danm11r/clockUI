# QtClock
Smart clock UI for the Raspberry Pi built with Python and QtQuick.

# About 
This app was built with Python and the PyQt5 toolkit. The UI is touch-based, and is intended to run on a Raspberry Pi connected to a round 1080x1080 LCD display. 

The current version is only a proof of concept, but feel free to give it a try! The app has three clockfaces which can be accessed by swiping left or right on a touch screen, or by clicking and dragging accross the window. Each clock faces provides the current time, date, and basic weather information. I've also added a rudimentary settings page for switching between the two avaliable color schemes. 
![clockdemo2](https://github.com/danm11r/QtClock/assets/148667664/27cdffc5-eb1d-4b7d-bb78-6f1c7303b4bc)

# Installation 
Here's a brief overview of installing the app on a Raspberry Pi with Raspberry Pi OS Lite, and configuring it to run on startup without a display manager. The app has been tested on both a Pi B+ and a Pi 4. Performance on the B+ was poor when swiping between clockfaces, I recommend using something newer. 

First, SSH into the Raspberry Pi, install git with `apt install git`, and clone the repo with `git clone https://github.com/danm11r/QtClock`. 

Then install python and the necessary PyQt5 packages with the following command:
`sudo apt-get install python3 python3.pyqt5 python3-pyqt5.qtquick qml-module-qtquick-shapes qml-module-qtquick-controls2`

The included clockfaces use the noto sans font family, install it with the following command: `sudo apt-get install fonts-noto`

You should now be able to run the app. From the QtQuick directory, run the following command to launch the app using the openGL renderer, bypassing the need for a display server: `python3 main.py --platform eglfs`
 











