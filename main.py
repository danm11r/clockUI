# Daniel Miller June 2024
# Rebuilding clockUI from scratch!

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
app.setOrganizationName("test")
app.setOrganizationDomain("test.com")
app.setApplicationName("test")

mainFont = QFont("noto sans")
app.setFont(mainFont)

engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('main.qml')

class Backend(QObject):

    #Signal for all time data
    time = pyqtSignal(int, int, int, str, str, bool, arguments=['hour', 'minute', 'second', 'hour_text', 'minute_text', 'PM'])
    date = pyqtSignal(str, int, int, arguments=['day', 'date', 'totalDays'])
    temp = pyqtSignal(int, int, int, int, arguments=['temp', 'tempL', 'tempH', 'tempErr'])

    def __init__(self):
        super().__init__()

        #100ms timer for time update
        self.timer1 = QTimer()
        self.timer1.setInterval(100)
        self.timer1.timeout.connect(self.update_time)
        self.timer1.start()

        #1s timer for date update
        self.timer2 = QTimer()
        self.timer2.setInterval(1000)
        self.timer2.timeout.connect(self.update_date)
        self.timer2.start()

        #1m timer for weather update. Runs once a minute
        self.timer3 = QTimer()
        self.timer3.setInterval(60000)
        self.timer3.timeout.connect(self.update_temp)
        self.timer3.start()

    def update_time(self):
        time = localtime()
        hour = strftime("%-I", localtime()) 
        minute = strftime("%M", localtime()) 
        if (strftime("%p").upper() == "PM"):
            PM = True
        else:
            PM = False

        self.time.emit(time.tm_hour % 12, time.tm_min, time.tm_sec, hour, minute, PM)

    def update_date(self):
        day = datetime.today().strftime('%a')
        date = int(datetime.today().strftime('%-d')) # Probably a way to get day of month in integer to avoid type casting... 
        totalDays = calendar.monthrange(datetime.today().year, datetime.today().month)[1]

        self.date.emit(day, date, totalDays)

    def update_temp(self):
        temp = get_curr_temp()

        self.temp.emit(round(temp[0]), (round(temp[1])), round(temp[2]), temp[3])


backend = Backend()
engine.rootObjects()[0].setProperty('backend', backend )
backend.update_time()
backend.update_date()
backend.update_temp()

sys.exit(app.exec())