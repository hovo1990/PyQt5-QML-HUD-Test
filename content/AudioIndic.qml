import QtQuick 2.2
import QtQuick.Controls 1.1
import myAudioModule 1.0

// Need to change my custom button name, else there's a collision


Item {
    id: root

    property bool isShown: false

    //my Part Start
    property real audioSliderValue: 0.5
    property real tempAudioSliderValue;
    //end

    anchors.fill: parent

    CustomAudioIndicatorItem{
        id: myAudioIndicItem
        audioVolume: audioSliderValue
//        muteAudio: false //This works commented
    }

    property bool testMek: myAudioIndicItem.muteAudio

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
        id: audioIndicator
        height:35; width:35 //Widget size
        anchors.right: parent.right
        anchors.rightMargin: 170
        anchors.top: parent.top
        anchors.topMargin: 10
        source: "icons/audioIndic.png"
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
        anchors.right: audioIndicator.horizontalCenter
        anchors.top: audioIndicator.verticalCenter
        width: Math.min(200, parent.width - 20)
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
            id: audioContainer
            anchors.horizontalCenter: parent.horizontalCenter
            y: 50
            MyCustomButton {
                //id:closeHUDButtonID
                id: myCustomButtonAudio

                anchors.horizontalCenter: parent.horizontalCenter
                effectsOn: root.visible
                text: "Mute"
                onClicked: {
                    if (text === "Mute") {
                        myCustomButtonAudio.text = "Unmute";
                        myAudioIndicItem.muteAudio = true;
                        tempAudioSliderValue = currentAudioSlider.value
                        currentAudioSlider.value = 0;
                   } else if( text ==="Unmute"){
                        myCustomButtonAudio.text = "Mute";
                        myAudioIndicItem.muteAudio = false;
                        currentAudioSlider.value = tempAudioSliderValue;
                    //console.debug("Order! TODO: implement");
                    }

              }
            }
            Rectangle {
                id: rectangleColumnAudio
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width -50
                height: 3
                color: "#404040"
            }      

            Slider {
                id: currentAudioSlider
                height: 400
                anchors.horizontalCenter: parent.horizontalCenter
                orientation: Qt.Vertical
                value: audioSliderValue //AudioSliderValue
                onValueChanged:{
//                    console.debug(testMek);
//                    if (pressed != true)
//                        console.debug(value);
                        audioSliderValue = value
                     //console.debug(value);
                 }
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
