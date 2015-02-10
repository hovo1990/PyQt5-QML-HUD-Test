/*
* SidePanelTab.qml
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

Item {
    id:root
//    opacity: 0.0

    property bool panelHidden: true
    property int pageIndex
    property string label: 'Panel Tab Top'

    property int mode: 0 // top: 0; bottom: 1

    property string colorActive: style.basysBlue
    property string colorEmboss: '#0077dd'

    signal clicked( int index )
    signal swiped()

    width: labelTextTop.width + 500
    height: 38
    clip: true

    state:'normal'

    states: [
        State {
            name:'normal'
            PropertyChanges {
                target:backgroundTop
                y:(mode == 0) ? -8 : 8
            }
        },
        State {
            name:'active'
            PropertyChanges {
                target:backgroundTop
                y:(mode == 0) ? 0 : 0
            }
        }
    ]

//    Rectangle {
//        id: background

//        height: parent.width + 9
//        width: parent.height
//        y: 0//(mode == 0) ? 0 : root.width - width
//        x: (mode == 0) ? -8 : 18
////        radius: 7
//        border.width: 1
//        smooth: true
//        transform: Rotation {
//            origin.x: width/2
//            origin.y: width/2
//            angle: 90
//        }

//        gradient: Gradient {
//            GradientStop {
//                position:(mode == 0) ? 0.0 : 1.0
//                color: (root.state == 'active') ? colorEmboss : '#777777'
//            }
//            GradientStop {
//                position:(mode == 0) ? 0.5 : 0.5
//                color: (root.state == 'active') ? colorActive : '#999999'
//            }
//        }
//    }

    Image {
        id: backgroundTop
        source: "images/sidebar_leave_top.png"
        opacity: 0.4 // test
        width: parent.width
        height: parent.height
        y: (mode == 0) ? -8 : 8
    }

    TabletCommonStyle { id: style }

    Text {
        id:labelTextTop
        anchors {
            verticalCenter:parent.verticalCenter
            horizontalCenter:parent.horizontalCenter
            horizontalCenterOffset: if(root.state == 'active'){
                0
            }
            else{
                (mode == 0) ? -2 : 2
            }
        }
        color: "white"
        font.bold: true
        text:root.label
        rotation: ( mode== 0) ? 0 : 0
    }

    MouseArea {
        property int initialX: 0
        property bool allowEvents: true //used to block the click event when a swipe was caught
        property int swipeOffSet: 30

        anchors.fill:parent

        hoverEnabled: true  //my part

//        containsMouse: {
//            root.opacity =  1.0
//        }

        onEntered:{
            root.opacity = 1.0
        }

        onExited:{
            root.opacity = 0.1
        }

        onClicked: {
            if( allowEvents ) {
                root.clicked( root.pageIndex )
                forceActiveFocus()
            }
        }
        onPressed: {
            initialX = mouse.x
            allowEvents = true
        }
        onPositionChanged: {
            if( allowEvents ) {
                if( root.mode == 0 ) {
                    if( root.panelHidden ) {
                        if( mouse.x > initialX + swipeOffSet ) {
                            root.swiped()
                            allowEvents = false
                        }
                    }else {
                        if( mouse.x < initialX - swipeOffSet ) {
                            root.swiped()
                            allowEvents = false
                        }
                    }
                }else {
                    if( root.panelHidden ) {
                        if( mouse.x < initialX - swipeOffSet ) {
                            root.swiped()
                            allowEvents = false
                        }
                    }else {
                        if( mouse.x > initialX + swipeOffSet ) {
                            root.swiped()
                            allowEvents = false
                        }
                    }
                }
            }
        }
    }
}
