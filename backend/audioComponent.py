# -*- coding: utf-8 -*-
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
import sys

from PyQt5.QtCore import QProcess, QTimer
from PyQt5.QtCore import QObject
from PyQt5.QtCore import QTime, QTimer, QDate
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QObject, QUrl, Qt
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine, QQmlProperty



class Audio_QProcess(QProcess):

      def __init__(self):
           #Call base class method
           QProcess.__init__(self)
           self.setProcessChannelMode(QProcess.MergedChannels)

           self.data = []
           self.final_data = None

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
          #print('res is ',res) #Need to parse this down
          temp = res.split("%")
          #print('shit ',temp)
          temp2 = temp[0].split('[')
          #print('fuck temp2 ',temp2)
          self.final_data = temp2[1]
          #return self.final_data
          #print('buhahah ',self.final_data)



      def getData(self):
          return self.final_data #Shit there's a problem'


      def killProcess(self):

            self.kill()




class AudioIndicator(QObject):
    def __init__(self,viewItem, parent=None):
        super(AudioIndicator, self).__init__(parent)

        self.qProcess = Audio_QProcess()
        self.qProcess.readyReadStandardOutput.connect(self.getRealCurrentVolume)

        self.currVolume = 0
        self.realValue = 0
        self.setVolume = 0

        self.muteActivated = False

        self.viewItem = viewItem
        rootObject = self.viewItem.rootObject()
        #print('rootObject audio Indic ', rootObject)


        self.rootContext = self.viewItem.rootContext()

        #It fucking worked Yeahhhhhhhhh
        muteButton = rootObject.findChild(QObject, "muteAudioButton")
        muteButton.messageRequired.connect(self.muteSystemAudio)
        ##win = self.qmlEngine.rootObjects()[0]
        ##print('win is ',win)

        self.audioSlider = rootObject.findChild(QObject, "audioIndicSlider")
        self.audioSlider.valueChanged.connect(self.changeVolume)

        self.getCurrentVolume()



        self.current_timer = QTimer()
        #self.current_timer.setSingleShot(True)
        self.current_timer.timeout.connect(self.changeVol)
        self.current_timer.start(700)
        #print('fucking button ',button)
        #button.closeHUD.connect(self.closeHUDfunc)


    def changeVol(self):
        #print('realValue ',self.realValue)
        #print('setVolume ',self.setVolume)
        if self.realValue != self.setVolume:
            self.setVolume = self.realValue
            self.setSystemAudio(self.setVolume)


    def setSystemAudio(self,audioValue):
        audio  = self.convertValToPyCombatible(audioValue)
        #-q is for quiet
        command = "amixer  -q -D pulse sset Master " + ("%s%%" %(str(audio)))
        os.system(command)

    def changeVolume(self):
        audioValue = float(QQmlProperty.read(self.audioSlider, "value"))
        #self.audioSlider.read(QObject, 'value')
        self.realValue = audioValue
        #print('fucking real value is ', self.realValue)
        #print('fucking value is ')
        #self.setVolumeSlider(realValue) #This is problematic




    def convertValToPyCombatible(self,value):
        return int(float(value)*100.0)

    def convertValToQMLCombatible(self,value):
        return float(value)/100.0



    def setVolumeSlider(self,value):
        self.rootContext.setContextProperty("audioSliderValue", value)


    def getCurrentVolume(self):
        #print('piece of shit motherfucker')
        self.qProcess.start('amixer get Master')


    def getRealCurrentVolume(self):
        self.currVolume = self.qProcess.getData()
        self.setVolume = self.convertValToQMLCombatible(self.currVolume)
        #print('currentVolume is ',self.setVolume)
        self.setVolumeSlider(self.setVolume)




    def muteSystemAudio(self):
        if self.muteActivated == False:
            self.muteActivated = True
            os.system('amixer -q -D pulse sset Master 0%')
            self.setVolumeSlider(0.0)
        else:
            self.muteActivated = False
            #print('fucking darn ',self.currVolume)
            command = "amixer -q -D pulse sset Master " + ("%s%%" %(str(self.currVolume)))
            #print('command is ',command)
            os.system(command)
            setVolume = self.convertValToQMLCombatible(self.currVolume)
            self.setVolumeSlider(setVolume)

    #def closeHUDfunc(self):
        #print('Fuck yeah close HUD')
        #sys.exit(0)

#if __name__ == '__main__':

    #import sys

    #app = QApplication(sys.argv)
    #clock = DigitalClock()
    #clock.show()
    #sys.exit(app.exec_())
##