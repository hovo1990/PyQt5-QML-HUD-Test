import QtQuick 2.2

//import QtQuick.Controls 1.3
//import QtQuick.Controls.Styles 1.3


Item {
    id: root

    property bool isShown: false


    //my Part start
//    objectName: "digitalClock"

    property string clockTime;
    property string dateInfoQTime;
    //Ends

    anchors.fill: parent

    function show() {
        isShown = true;
        hideAnimation.stop();
        showAnimation.restart();
    }
    function hide() {
        isShown = false;
        showAnimation.stop();
        hideAnimation.restart();
    }

    SequentialAnimation {
        id: showAnimation
        PropertyAction { target: backgroundItem; property: "visible"; value: true }
        ParallelAnimation {
            NumberAnimation { target: backgroundItem; property: "opacity"; to: 1; duration: 250; easing.type: Easing.InOutQuad }
            NumberAnimation { target: backgroundItem; property: "scale"; to: 1; duration: 500; easing.type: Easing.OutBack }
        }
    }
    SequentialAnimation {
        id: hideAnimation
        ParallelAnimation {
            NumberAnimation { target: backgroundItem; property: "opacity"; to: 0; duration: 500; easing.type: Easing.InOutQuad }
            NumberAnimation { target: backgroundItem; property: "scale"; to: 0.6; duration: 500; easing.type: Easing.InOutQuad }
        }
        PropertyAction { target: backgroundItem; property: "visible"; value: false }
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.isShown
        onClicked: {
            root.hide();
        }
    }

    Text {
        id: clockTime
        text:  Qt.formatTime(new Date(),"hh:mm")
        //text: "01:20"
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.top: parent.top
        anchors.topMargin: 10
        elide: Text.ElideRight
        font.pixelSize: 34
        color: "#ffffff"
        //opacity: backgroundItem.opacity + 0.1
        MouseArea {
            anchors.fill: parent
            anchors.margins: -20
            onClicked: {
                if (root.isShown) {
                    root.hide();
                } else {
                    root.show();
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 60000
        repeat: true
        running: true

        onTriggered:
        {
            clockTime.text =  Qt.formatTime(new Date(),"hh:mm")
        }
    }

    BorderImage {
        id: backgroundItem
        anchors.right: clockTime.horizontalCenter
        anchors.top: clockTime.verticalCenter
        width: Math.min(480, parent.width - 60)
        height: settingsContentColumn.height-20 + 120
        source: "images/panel_bg_inverse.png"
        border.left : 10
        border.right : 22
        border.top : 50
        border.bottom : 26

        transformOrigin: Item.TopRight // extra window direction comes from
        visible: false
        opacity: 0
        scale: 0.6

        Column {
            id: settingsContentColumn
            width: parent.width
            y: 14
            InfoText {
                text: "Date:"
                text2: Qt.formatDate(new Date(),"ddd MM yyyy")
            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 32
                height: 1
                color: "#404040"
            }
//            Calendar { #Not Yet it's available on version 1.3
//                    id: calendar
//                    anchors.centerIn: parent
//                    style: CalendarStyle {
//                        dayDelegate: Item {
//                            Rectangle {
//                                id: rect
//                                anchors.fill: parent

//                                Label {
//                                    id: dayDelegateText
//                                    text: styleData.date.getDate()
//                                    anchors.centerIn: parent
//                                    horizontalAlignment: Text.AlignRight
//                                    font.pixelSize: Math.min(parent.height/3, parent.width/3)
//                                    color: styleData.selected ? "red" : "black"
//                                    font.bold: styleData.selected
//                                }
//                                MouseArea {
//                                    anchors.horizontalCenter: parent.horizontalCenter
//                                    anchors.verticalCenter: parent.verticalCenter
//                                    width: styleData.selected ? parent.width / 2 : 0
//                                    height: styleData.selected ? parent.height / 2 : 0
//                                    Rectangle {
//                                        anchors.fill: parent
//                                        color: "transparent"
//                                        border.color: "darkorange"
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }

        }

//        Button {
//            anchors.bottom: settingsContentColumn.bottom
//            anchors.bottomMargin: -75
//            anchors.left: settingsContentColumn.left
//            anchors.leftMargin: 32
//            text: "Back"
//            effectsOn: false
//            onClicked: {
//                root.hide();
//            }
//        }
//        Button {
//            anchors.bottom: settingsContentColumn.bottom
//            anchors.bottomMargin: -75
//            anchors.right: settingsContentColumn.right
//            anchors.rightMargin: 32
//            effectsOn: root.visible
//            text: "Order"
//            onClicked: {
//                console.debug("Order! TODO: implement");
//            }
//        }
    }
}


/*
Item {
    id: root
    property int custom_width: 40
    property int custom_height: 40

    width: custom_width
    height: custom_height

    Image {
        id: wifi_image
        width: custom_width; height: custom_height
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "icons/wifi36.png"

    }
}
*/
