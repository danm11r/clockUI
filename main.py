# Daniel Miller Jan 2024

import sys
import random

from PyQt5.QtGui import QGuiApplication, QFont
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QTimer, QObject, pyqtSignal

from time import strftime, localtime
from datetime import datetime
from weather import get_curr_temp
import calendar

app = QGuiApplication(sys.argv)

mainFont = QFont("noto sans")
app.setFont(mainFont)

engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('main.qml')

class Backend(QObject):

    # Signals for clock data (time, date, temp, etc)
    time = pyqtSignal(str, str, bool, arguments=['time_hour', 'time_minute', 'PM'])
    date = pyqtSignal(str, str, int, arguments=['day', 'date', 'datePos'])
    temp = pyqtSignal(str, str, str, int, int, arguments=['temp', 'tempL', 'tempH', 'tempPos', 'tempErr'])
    hms = pyqtSignal(int, int, int, arguments=['hour', 'minute', 'second'])

    def __init__(self):
        super().__init__()

        # 100 ms timer for time update
        self.timer1 = QTimer()
        self.timer1.setInterval(100)
        self.timer1.timeout.connect(self.update_time)
        self.timer1.timeout.connect(self.update_hms)
        self.timer1.start()

        # 1 min timer for weather update
        self.timer2 = QTimer()
        self.timer2.setInterval(60000)
        self.timer2.timeout.connect(self.update_temp)
        self.timer2.start()

        # 1s timer for date update
        self.timer3 = QTimer()
        self.timer3.setInterval(1000)
        self.timer3.timeout.connect(self.update_date)
        self.timer3.start()

    # Get current time in string format, and set bool value if PM
    def update_time(self):
        curr_time_hour = strftime("%-I", localtime()) 
        curr_time_min = strftime("%M", localtime()) 
        if (strftime("%p").upper() == "PM"):
            PM = True
        else:
            PM = False
        self.time.emit(curr_time_hour, curr_time_min, PM)

    # Get current date and day. Determine position of month progress bar for widget
    def update_date(self):
        curr_day = datetime.today().strftime('%a')
        curr_date = datetime.today().strftime('%-d') 

        now = datetime.today()
        num_days = calendar.monthrange(now.year, now.month)[1]
        date_position = round(((now.day) * (360)) / (num_days))
 
        self.date.emit(curr_day, curr_date, date_position)

    # Call function to get the temp, max and min. Determine position of widget temp guage ranging from min to max temp
    def update_temp(self):
        curr_temp = get_curr_temp()

        if (curr_temp[1] != curr_temp[2]):
            curr_temp_pos = round(((curr_temp[0] - curr_temp[1]) * (180 - 1)) / (curr_temp[2] - curr_temp[1]))
        else:
            curr_temp_pos = 180
        
        self.temp.emit(str(round(curr_temp[0])) + "\N{DEGREE SIGN}", str(round(curr_temp[1])), str(round(curr_temp[2])), curr_temp_pos, curr_temp[3])

    # Int values for current hour, minute, and second. Useful for analog clock display
    def update_hms(self):
        curr_hms = localtime()
        self.hms.emit(curr_hms.tm_hour, curr_hms.tm_min, curr_hms.tm_sec)

backend = Backend()
engine.rootObjects()[0].setProperty('backend', backend )
backend.update_temp()

#backend.update_time()
sys.exit(app.exec())