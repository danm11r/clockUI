# clockUI
Smart clock UI for the Raspberry Pi built with Python and QtQuick.

# About
This app was built with Python and the PyQt5 toolkit. The UI is touch-based, and is intended to run on a Raspberry Pi connected to a round 1080x1080 LCD display. Demo video coming soon!

The current version is only a proof of concept, but feel free to give it a try! The app has multiple clockfaces which can be viewed by swiping left or right on a touch screen, or by clicking and dragging accross the window. Each clock faces provides the current time, date, and basic weather information. There is also a basic settings page for switching between the avaliable color schemes.

Here's a look at the clockUI app in action:
![clock](https://github.com/user-attachments/assets/4a847fd9-6198-4871-ad4f-db1fdc318ac1)

Swiping through the clock faces and changing the color theme:
![clockdemp2](https://github.com/user-attachments/assets/6b22e396-7e40-487a-bff8-3f64b20c50eb)

# Setup
The app expects to find a `.env` file containing an open weather API key, zip code, and unit type. This information is used to generate the API request for temperature data. An example file, `.env-example`, is provided. Simply rename the file to `.env` and fill in the necessary data.

# Installation on Raspberry Pi
Here's a brief overview of installing the app on a Raspberry Pi with Raspberry Pi OS Lite, and running it without a display manager. The app has been tested on both a Pi B+ and a Pi 4. Performance on the B+ was poor when swiping between clockfaces, I recommend using something newer.

First, SSH into the Raspberry Pi, install git with `apt install git`, and clone the repo with `git clone https://github.com/danm11r/clockUI`.

Then install Python and the necessary PyQt5 packages using the included install script. To run this script, make it executable with `chmod +x install.sh` and execute with `./install.sh`

You should now be able to run the app. From the clockUI directory, run the following command to launch the app using the openGL renderer, bypassing the need for a display server: `python3 main.py --platform eglfs`.










