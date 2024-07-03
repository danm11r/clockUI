# Daniel Miller June 2024
# Rebuilding clockUI from scratch!

# This program is for testing everything...

import sys
import random

from PyQt5.QtGui import QGuiApplication, QFont
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QTimer, QObject, pyqtSignal

from time import strftime, localtime

app = QGuiApplication(sys.argv)
app.setOrganizationName("Some Company")
app.setOrganizationDomain("somecompany.com")
app.setApplicationName("Amazing Application")

engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)
engine.load('main.qml')

i = 0
hour = 0
minute = 0

class Backend(QObject):

    #Signal for all time data
    time = pyqtSignal(int, int, int, str, str, bool, arguments=['hour', 'minute', 'second', 'hour_text', 'minute_text', 'PM'])
    date = pyqtSignal(str, int, int, arguments=['day', 'date', 'totalDays'])
    temp = pyqtSignal(str, str, str, int, arguments=['temp', 'tempL', 'tempH', 'tempErr'])

    def __init__(self):
        super().__init__()

        # 100 ms timer for time update
        self.timer1 = QTimer()
        self.timer1.setInterval(10)
        self.timer1.timeout.connect(self.update_time)
        self.timer1.start()

        self.count = 0
        self.minute = 0
        self.hour = 0

    def update_time(self):

        self.count = self.count + 1

        #print(self.count % 60)

        if ((self.hour % 24) >= 12):
            PM = True
        else:
            PM = False

        if ((self.count % 60) == 0):
            self.minute = self.minute + 1

        if ((self.count % 3600) == 0):
            self.hour = self.hour + 1

        self.time.emit((self.hour % 24), (self.minute % 60), (self.count % 60), "12", "59", True)

    def update_date(self):

        self.date.emit("XXX", 32, 33)

    def update_temp(self):

        self.temp.emit(str(100), str(100), str(100), 0)

backend = Backend()
engine.rootObjects()[0].setProperty('backend', backend )
backend.update_time()
backend.update_date()
backend.update_temp()

sys.exit(app.exec())
