/*
* CommonStyle.qml
*
* Copyright (C) 2009-2011 basysKom GmbH
*
* This library is free software; you can redistribute it and/or
* modify it under the terms of the GNU Lesser General Public
* License as published by the Free Software Foundation; either
* version 2.1 of the License, or (at your option) any later version.
*
* This library is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public
* License along with this library; if not, write to the Free Software
* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

import QtQuick 2.2

QtObject {

    property color pageBackground: '#000000'
    property color pageText: '#ffffff'
    property color titleTextColor: '#ffffff'
    property color windowBackground: '#555555'
    property color conversationBackground: '#000000'
    property color conversationTitlebar: '#00CCFF'
    property color panelBackground: '#0099ff' // "lightsteelblue"
    property color basysBlue: '#0099ff'
    property color backgroundGrey: '#333333'
    property color sideBarBackgroundGrey: '#333333'
    property color modalDialogBackground: "#4f4f4f"
    property color notificationBarBackground: "#4f4f4f"

    property variant conversationToolbarGradient: Gradient {
        GradientStop { position: 0.0; color: '#0066CC' }
        GradientStop { position: 0.25; color: '#00CCFF' }
        GradientStop { position: 0.75; color: '#00CCFF' }
        GradientStop { position: 1.0; color: '#0066CC' }
    }

    property real conversationToolbarHeight: 50
    property real conversationTitlebarHeight: 50

    property int sideBarHeaderHeight: 68
    property int sideBarFooterHeight: 67
    property int listTextSizeStandard: 16
    property int textChatSize: 28
}

