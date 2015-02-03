import QtQuick 2.2

// Need to change my custom button name, else there's a collision


Item {
    id: root

    property bool isShown: false

    //my Part Start

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

    Image {
        id: cameraIndicator
        height:35; width:35 //Widget size
        anchors.right: parent.right
        anchors.rightMargin: 270
        anchors.top: parent.top
        anchors.topMargin: 10
        source: "icons/cameraIndic.png"
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

    BorderImage {
        id: backgroundItem
        anchors.right: cameraIndicator.horizontalCenter
        anchors.top: cameraIndicator.verticalCenter
        width: Math.min(200, parent.width - 20) + 80
        //height: settingsContentColumn.height + 1000
        height: 550
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
            id: settingsCameraContentColumn
            anchors.horizontalCenter: parent.horizontalCenter
            y: 50
            width: parent.width
            Switch {
                text: "Activate Video"
                checked: settings.cameraActive
                onCheckedChanged: {
                    settings.cameraActive = checked;
                }
            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width -50
                height: 3
                color: "#404040"
            }
            Switch {
                text: "Activate FR"
                checked: settings.facialRecognitionActive
                onCheckedChanged: {
                    settings.facialRecognitionActive = checked;
                }
            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width -50
                height: 3
                color: "#404040"
            }
        }
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
