#!/bin/bash

# Start script for clockUI

{
echo Starting clockUI at $(date)
source venv/bin/activate
python3 main.py --platform eglfs
} &>> log.txt
