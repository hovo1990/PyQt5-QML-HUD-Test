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
        activateVideo: settings.cameraActive
        activateFaceRecognition: settings.facialRecognitionActive
        //property string myColor: "green"

    }
}

