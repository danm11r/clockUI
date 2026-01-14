#!/bin/bash

# Install necessary packages
# Note: this is no longer necessary, as pip is now used to manage packages
#sudo apt-get install python3 python3.pyqt5 python3-pyqt5.qtquick qml-module-qtquick-shapes qml-module-qtquick-controls2 qml-module-qtquick-window2 python3-dotenv qml-module-qt-labs-settings -y

# Install necessary packages
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Install font
sudo apt-get install fonts-noto -y