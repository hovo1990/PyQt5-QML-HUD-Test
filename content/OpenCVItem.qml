import QtQuick 2.2
import myOpenCVmodule 1.0

Item {

    id: root
//    color: "black"
//    width: 1280
//    height: 720
    anchors.fill: parent

    CustomOpenCVItem {
        id: testCustomOpenCVItem
        anchors.fill: parent
        cameraID: 0
        activateVideo: true
        activateFaceRecognition: false
        //property string myColor: "green"
//        x: 100
//        y: 100
        //anchors.centerIn: parent
//        width: 640
//        height: 480
//        color: "green"

//        onReadySignal: {
//            color = "blue"
//        }

//        onReadyChanged: {
//            readyStatus.text = value;
//        }

//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
////                Qt.quit();
//                parent.color = 'red';
//            }
//        }
    }

//    Text {
//        id: readyStatus
//        text: "Hello world"
//        font.pixelSize: 32
//    }
}

