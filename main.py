#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os.path

from PyQt5.QtCore import QObject,  Qt
from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView

from PyQt5.QtCore import pyqtProperty, QCoreApplication, QObject, QUrl
from PyQt5.QtQml import qmlRegisterType, QQmlComponent, QQmlEngine

from backend import customOpenCV #import CustomOpenCVItem #This works like a marvel
from backend import audioComponent #import CustomOpenCVItem #This works like a marvel
from backend import wifiComponent #import CustomOpenCVItem #This works like a marvel



#import myQML

app = QGuiApplication(sys.argv)

qmlRegisterType(customOpenCV.CustomOpenCVItem, 'myOpenCVmodule', 1, 0, 'CustomOpenCVItem') #UberImportant
qmlRegisterType(audioComponent.CustomAudioIndicatorItem, 'myAudioModule', 1, 0, 'CustomAudioIndicatorItem') #UberImportant
qmlRegisterType(wifiComponent.CustomWifiIndicatorItem, 'myWifiModule', 1, 0, 'CustomWifiIndicatorItem') #UberImportant


print('-----------------------------------------------------------------------')



qmlFile = 'main.qml'

#qmlFile = "qrc:data/"


view = QQuickView()
view.setResizeMode(QQuickView.SizeRootObjectToView)
view.engine().quit.connect(app.quit)

engine = view.engine()
view.setSource(QUrl(qmlFile)) # putting at the end didn't solve referenceError 'This is supposed to solve all referenceErrors

object = view.rootObject()
print('root object is ',object)
#object.ValueChanged.connect(printTest)


view.show()
sys.exit(app.exec_())

