# ClockUI
Smart clock UI for the Raspberry Pi built with Python and Qt Quick.

# About
ClockUI is a PyQt5 based smart clock UI. The UI is touch-based, and is intended to run on a Raspberry Pi (model 3 or later recommended) connected to a round LCD display. The app features multiple clockfaces which can be viewed by swiping left or right on a touch screen, or by clicking and dragging across the window. Each clock face provides the current time, date, and basic weather information provided by OpenWeather. In addition, there is a basic settings page for switching between the available color schemes. [You can learn more about clockUI here.](https://danm11r.github.io/2024/08/22/clockUI.html)

Here's a look at the clockUI app in action, running on a Pi 4 connected to a 5" round LCD:
![clock](https://github.com/user-attachments/assets/4a847fd9-6198-4871-ad4f-db1fdc318ac1)

Swiping through the clock faces and changing the color theme:
![clockdemp2](https://github.com/user-attachments/assets/6b22e396-7e40-487a-bff8-3f64b20c50eb)

# Hardware
While not required, I recommend using ClockUI with a round display, as the UI was designed specifically with that formfactor in mind. There are a few different options on the market, I used a 5" 1080x1080 display from Waveshare that can be purchased on Amazon. Any screen resolution should work, the UI is designed to scale entirely from the main window resolution. If you launch ClockUI using the eglfs method below, it should scale up to the horizontal resolution of your display. 

# Setup
The app expects to find a `.env` file containing an open weather API key, zip code, and unit type. This information is used to generate the API request for temperature data. An example file, `.env-example`, is provided. Simply rename the file to `.env` and fill in the necessary data.

# Installation on Raspberry Pi
Here's a brief overview of installing the app on a Raspberry Pi with Raspberry Pi OS Lite, and running it without a display manager. The app has been tested on both a Pi B+ and a Pi 4. Performance on the B+ was poor when swiping between clockfaces, I recommend using something newer.

First, SSH into the Raspberry Pi, install git with `apt install git`, and clone the repo with `git clone https://github.com/danm11r/clockUI`.

Then install Python and the necessary PyQt5 packages using the included install script. To run this script, make it executable with `chmod +x install.sh` and execute with `./install.sh`

You should now be able to run the app. From the clockUI directory, run the following command to launch the app using the openGL renderer, bypassing the need for a display server: `python3 main.py --platform eglfs`.
