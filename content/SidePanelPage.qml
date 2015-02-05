/*
* SidePanelPage.qml
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

import QtQuick 1.0
import Peregrine.Components.Base 0.1

Item {
    id:root

    anchors.fill:parent

    property alias pageTitle: pageTitle.text
    property alias content: content.children
    property alias buttonContent: buttonsArea.children
    property bool footerVisible: false

    signal hide()

    QtObject {
        id: p
        property int mode: root.parent.parent.mode
    }

    states: [
        State {
            name:'shown'
            PropertyChanges {target:root; visible:true}
            PropertyChanges {target:content; x:0}
        },
        State {
            name:'hidden'
            PropertyChanges {target:root; visible:false}
            PropertyChanges {target:content; x: (p.mode) ? content.width : -content.width }
        }
    ]

    TabletCommonStyle { id: style }

    Item {
        id:title
        height: style.sideBarHeaderHeight
        anchors {
            left:parent.left
            right:parent.right
            top:parent.top
        }
    }

    Text {
        id:pageTitle
        height:title.height
        width: parent.width

        verticalAlignment: Text.AlignVCenter

        font.pixelSize: height / 2
        color: style.titleTextColor
        x: 20
    }

    Image {
        id: footerBckg
        source: "images/sidebar_navigation_bg.png"
        width: parent.width
        height: buttonsArea.height
        y: parent.height - height
        visible: height > 0
    }

    Item {
        id: buttonsArea

        height: (footerVisible) ? style.sideBarFooterHeight : 0
        visible: height > 0
        anchors {
            left:parent.left; right:parent.right; bottom:parent.bottom;
            leftMargin: 5
            rightMargin: 5
        }
    }

    Rectangle {
        y: pageTitle.height + window.style.margin
        x: window.style.margin
        width: parent.width - window.style.margin - window.style.margin
        height: parent.height - pageTitle.height - buttonsArea.height - window.style.margin - window.style.margin
        color: style.sideBarBackgroundGrey
        clip:true

        Item {
            id:content
            //x: 0
            width: parent.width
            height: parent.height
            clip:true

            Behavior on x {
                PropertyAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

}
