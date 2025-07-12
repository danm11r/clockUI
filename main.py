# Daniel Miller June 2024
# clockUI Raspberry Pi Smart Clock

import sys
import random

from PyQt5.QtGui import QGuiApplication, QFont
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QTimer, QObject, pyqtSignal, pyqtSlot, QThread

from time import strftime, localtime
from datetime import datetime
from weather import get_curr_temp, update_env_units
import calendar
import os

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

    # Signals for QML
    time = pyqtSignal(int, int, int, str, str, str, bool, arguments=['hour', 'minute', 'second', 'hour_12_text', 'hour_24_text', 'minute_text', 'PM'])
    date = pyqtSignal(str, int, int, arguments=['day', 'date', 'totalDays'])
    temp = pyqtSignal(int, int, int, bool, int, arguments=['temp', 'tempL', 'tempH', 'tempMetric', 'tempErr'])

    # Signals for temperature worker
    updateTemp = pyqtSignal()

    def __init__(self):
        super().__init__()

        # 100ms timer for time update
        self.timer1 = QTimer()
        self.timer1.setInterval(100)
        self.timer1.timeout.connect(self.update_time)
        self.timer1.start()

        # 1s timer for date update
        self.timer2 = QTimer()
        self.timer2.setInterval(1000)
        self.timer2.timeout.connect(self.update_date)
        self.timer2.start()

        # 1m timer for temperature update. Runs once a minute
        self.timer3 = QTimer()
        self.timer3.setInterval(60000)
        self.timer3.timeout.connect(self.update_temp)
        self.timer3.start()

        # Create worker for temperature script
        self.temp_worker = TempWorker()
        self.thread = QThread()

        self.temp_worker.temp.connect(self.temp)
        self.temp_worker.moveToThread(self.thread)

        self.updateTemp.connect(self.temp_worker.update)

        self.thread.start()

    def update_time(self):
        time = localtime()
        hour_12 = strftime("%-I", localtime()) 
        hour_24 = strftime("%-H", localtime()) 
        minute = strftime("%M", localtime()) 
        if (strftime("%p").upper() == "PM"):
            PM = True
        else:
            PM = False

        self.time.emit(time.tm_hour, time.tm_min, time.tm_sec, hour_12, hour_24, minute, PM)

    def update_date(self):
        day = datetime.today().strftime('%a')
        date = int(datetime.today().strftime('%-d'))
        totalDays = calendar.monthrange(datetime.today().year, datetime.today().month)[1]

        self.date.emit(day, date, totalDays)

    # Manually refresh temperature data
    @pyqtSlot()
    def update_temp(self):
        
        self.updateTemp.emit()

    # Update units in .env file from settings page
    @pyqtSlot(bool)
    def update_units(self, i):

        err = update_env_units(i)

        # If no error, refresh temperature
        if err == 0:
            self.update_temp()

    # Update the DSI display brightness using brightnessctl
    # This is most likely a temporary implimentation
    @pyqtSlot(int)
    def update_brightness(self, i):

        print("Updating brightness...")
        os.system("brightnessctl set " + str(i))
        print(i)

# Worker thread for temperature data API access
class TempWorker(QObject):

    temp = pyqtSignal(int, int, int, bool, int, arguments=['temp', 'tempL', 'tempH', 'tempMetric', 'tempErr'])

    # Fetch temperature data using seperate script
    def update(self):

        print("TempWorker: Calling script for temperature data...")
        temp = get_curr_temp()
        
        self.temp.emit(round(temp[0]), (round(temp[1])), round(temp[2]), temp[3], temp[4])

backend = Backend()
engine.rootObjects()[0].setProperty('backend', backend )
backend.update_time()
backend.update_date()
backend.update_temp()

sys.exit(app.exec())