import QtQuick 2.0


Item {
    id: root

    property bool isShown: false


    //my Part start
    objectName: "digitalClock"
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
        id: clockText
        text: clockTime
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

    BorderImage {
        id: backgroundItem
        anchors.right: clockText.horizontalCenter
        anchors.top: clockText.verticalCenter
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
                text2: dateInfoQTime
            }
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 32
                height: 1
                color: "#404040"
            }              
        }

        Button {
            anchors.bottom: settingsContentColumn.bottom
            anchors.bottomMargin: -75
            anchors.left: settingsContentColumn.left
            anchors.leftMargin: 32
            text: "Back"
            effectsOn: false
            onClicked: {
                root.hide();
            }
        }
        Button {
            anchors.bottom: settingsContentColumn.bottom
            anchors.bottomMargin: -75
            anchors.right: settingsContentColumn.right
            anchors.rightMargin: 32
            effectsOn: root.visible
            text: "Order"
            onClicked: {
                console.debug("Order! TODO: implement");
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
