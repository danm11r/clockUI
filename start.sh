#!/bin/bash

# Start script for clockUI

# crontab will execute this script from the user's home directory, 
# so it is necessary to change into the clockUI directory

{
echo Starting clockUI at $(date)
cd clockUI
source venv/bin/activate
python3 main.py --platform eglfs
} &>> log.txt
