# ClockUI
Smart clock UI for the Raspberry Pi built with Python and Qt Quick.

![clock](https://github.com/user-attachments/assets/4a847fd9-6198-4871-ad4f-db1fdc318ac1)

# About
ClockUI is a PySide6 based smart clock UI. The UI is touch-based, and is intended to run on a Raspberry Pi (model 3 or later recommended) connected to a round LCD display. The app features multiple clock faces which can be viewed by swiping left or right on a touch screen, or by clicking and dragging across the app window. Each clock face provides the current time, date, and basic weather information provided by the OpenWeather API. In addition, there is a settings page that allows the user to toggle 12 or 24 hour time, choose between metric or imperial units for weather, and adjust the brightness of the display (assuming a compatible LCD is used). [You can learn more about clockUI here.](https://danm11r.github.io/2024/08/22/clockUI.html)

Here's a look at all available clock faces, in the order that they are presented to the user:
![Image](https://github.com/user-attachments/assets/0d6fca69-0f52-4805-9ae5-3e966c8fce2e)

A quick demo of UI navigation:
![Image](https://github.com/user-attachments/assets/003a491a-72c3-4477-9536-0e20eb964f61)

# Hardware
While not required, I recommend using ClockUI with a round display, as the UI was designed specifically with that form factor in mind. There are a few different options on the market, I used a 4" 720x720 display from Waveshare that can be purchased on Amazon. Any screen resolution should work, the UI is designed to scale based on the main window resolution. If you launch ClockUI using the eglfs method below, it should scale up to match the horizontal resolution of your display. 

# To-Do
- Add additional clock faces

# Setup
The app expects to find a `.env` file containing an open weather API key, zip code, and unit type. This information is used to generate the API request for temperature data. An example file, `.env-example`, is provided. Simply rename the file to `.env` and fill in the necessary data.

# Installation on Raspberry Pi
Here's a brief overview of installing the app on a Raspberry Pi with Raspberry Pi OS Lite, and running it without a display manager.

First, SSH into the Raspberry Pi, install git with `apt install git`, and clone the repo with `git clone https://github.com/danm11r/clockUI`.

Then create a Python virtual environment and install the necessary PySide6 packages using the included install script. To run this script, make it executable with `chmod +x install.sh` and execute with `./install.sh`

You should now be able to run the app. From the clockUI directory, run the following command to launch the app using the openGL renderer, bypassing the need for a display server: `python3 main.py --platform eglfs`.
