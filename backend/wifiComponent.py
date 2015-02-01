# -*- coding: utf-8 -*-
# -*- coding: utf-8 -*-

# -*- coding: utf-8 -*-
#!/usr/bin/env python


#############################################################################
##
## Copyright (C) 2013 Riverbank Computing Limited.
## Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
## All rights reserved.
##
## This file is part of the examples of PyQt.
##
## $QT_BEGIN_LICENSE:BSD$
## You may use this file under the terms of the BSD license as follows:
##
## "Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are
## met:
##   * Redistributions of source code must retain the above copyright
##     notice, this list of conditions and the following disclaimer.
##   * Redistributions in binary form must reproduce the above copyright
##     notice, this list of conditions and the following disclaimer in
##     the documentation and/or other materials provided with the
##     distribution.
##   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
##     the names of its contributors may be used to endorse or promote
##     products derived from this software without specific prior written
##     permission.
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
## A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
## OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
## LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
## DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
## THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
## $QT_END_LICENSE$
##
#############################################################################

import os
#from PyQt5.QtCore import QPoint, Qt, QTime, QTimer
#from PyQt5.QtGui import QColor, QPainter, QPolygon
#from PyQt5.QtWidgets import QApplication, QWidget

from PyQt5.QtCore import QObject
from PyQt5.QtCore import QFileInfo, QRegExp, QSize, Qt
from PyQt5.QtGui import QIcon, QImage, QPalette, QPixmap
from PyQt5.QtWidgets import (QAbstractItemView, QAction, QActionGroup,
        QApplication, QComboBox, QFileDialog, QFrame, QGridLayout, QGroupBox,
        QHBoxLayout, QHeaderView, QItemDelegate, QLabel, QMainWindow,
        QMessageBox, QRadioButton, QSizePolicy, QSpinBox, QStyle,
        QStyleFactory, QTableWidget, QTableWidgetItem, QVBoxLayout, QWidget)

from PyQt5.QtCore import QDir, Qt
from PyQt5.QtCore import QProcess, QTimer
from PyQt5.QtGui import QImage, QPainter, QPalette, QPixmap
from PyQt5.QtWidgets import (QAction, QApplication, QFileDialog, QLabel,
        QMainWindow, QMenu, QMessageBox, QScrollArea, QSizePolicy)
from PyQt5.QtQml import QQmlApplicationEngine, QQmlProperty



icons_folder = "/home/john1990/Dropbox/GitHub/HUD/QGS_test/customWidgets/icons/"
import os,sys

#from ui_wifi_Info import Ui_Wifi_Info




#command to scan wifis iwlist scan
#command to see iwconfig




class Wifi_QProcess(QProcess):

      def __init__(self):
           #Call base class method
           QProcess.__init__(self)
           self.setProcessChannelMode(QProcess.MergedChannels)

           self.data = []
           self.final_data = []

           self.readyReadStandardOutput.connect(self.readStdOutput)
           self.finished.connect(self.killProcess)

      #Define Slot Here
      #@pyqtSlot()
      def readStdOutput(self):
          self.res = str(self.readAllStandardOutput())
          #print(res)
          #test = self.res.split("\\n")
          self.parseOutput(self.res)

      def parseOutput(self, res):
          temp1 = res.split("wlan0")
          #print('shit ',temp1)
          if len(temp1)>1:
              temp2 = temp1[1].split('  ')
              #print('shit2 ',temp2)
              for data in temp2:
                    if 'IEEE' in data:
                        res = data.split(' ')
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
                    elif 'ESSID' in data:
                        res = data.split(":")
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
                    elif 'Mode' in data:
                        res = data.split(":")
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
                    elif 'Frequency' in data:
                        res = data.split(":")
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
                    elif 'Access Point' in data:
                        res = data.split(":")
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
                    elif 'Bit Rate' in data:
                        res = data.split("=")
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
                    elif 'Link Quality' in data:
                        res = data.split("=")
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
                    elif 'Signal level' in data:
                        res = data.split("=")
                        #print(res)
                        self.data.append(res[-1])
                        #print(self.data)
          self.final_data = self.data[:]
          self.data = []
          #print(self.data)
          #self.data = []

      def getData(self):
          return self.final_data


      def killProcess(self):
            #print('fuck')
            #print(self.res)
            #print('------------------'*10)
            #self.terminate()
            #sys.exit(0)

            self.kill()



#class wifi_Info(QWidget,Ui_Wifi_Info):

class wifi_Info(QObject):
    def __init__(self, viewItem, parent = None):
        super(wifi_Info, self).__init__(parent)

        self.qProcess = Wifi_QProcess()

        self.viewItem = viewItem


        self.rootContext = self.viewItem.rootContext()
        #qProcess.setProcessChannelMode(QProcess.MergedChannels)

        rootObject = self.viewItem.rootObject()
        self.wifiIndicator = rootObject.findChild(QObject, "wifiIndicator") #This works
        #self.wifiIndicator = rootObject.findChild(rootObject, "myWifiIndicator")

        timer = QTimer(self)
        timer.timeout.connect(self.update)
        timer.start(700)


    def update(self):
        self.qProcess.start("iwconfig")
        #self.qProcess.kill()
        final_data = self.qProcess.getData()
        #print(final_data)
        if len(final_data)> 1:
            self.updateValues(final_data)

    def updateValues(self,values):
        QQmlProperty.write(self.wifiIndicator, "ieee_RES",str(values[0]) )
        QQmlProperty.write(self.wifiIndicator, "essid_RES",str(values[1]) )
        QQmlProperty.write(self.wifiIndicator, "mode_RES",str(values[2]) )
        QQmlProperty.write(self.wifiIndicator, "frequency_RES",str(values[3]) )
        QQmlProperty.write(self.wifiIndicator, "access_Point_RES",str(values[4]) )
        QQmlProperty.write(self.wifiIndicator, "bitRate_RES",str(values[5]) )
        QQmlProperty.write(self.wifiIndicator, "linkQuality_RES",str(values[6]) )
        QQmlProperty.write(self.wifiIndicator, "signalLevel_RES",str(values[7]) )


#if __name__ == '__main__':

    #import sys

    #app = QApplication(sys.argv)
    #wifi_Info = wifi_Info()
    #wifi_Info.show()
    #sys.exit(app.exec_())









