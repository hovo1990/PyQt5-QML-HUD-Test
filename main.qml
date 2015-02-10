import QtQuick 2.2
import "content"



Item {
    id: mainWindow

    width: 1280
    height: 720

    QtObject {
        id: settings
        // These are used to scale fonts according to screen size
        property real _scaler: 300 + mainWindow.width * mainWindow.height * 0.00015
        property int fontXS: _scaler * 0.032
        property int fontS: _scaler * 0.040
        property int fontM: _scaler * 0.046
        property int fontMM: _scaler * 0.064
        property int fontL: _scaler * 0.100
        // Settings
        property bool showFogParticles: true
        property bool showShootingStarParticles: true
        property bool showLighting: true
        property bool showColors: true

        property bool cameraActive: true
        property bool facialRecognitionActive: false
    }

    MainView {
        id: mainView
    }

    SidePanel{   //VEry important
        id: sidePanelLeft
    }

    SidePanelTop{   //VEry important
        id: sidePanelTop
    }

    /*
    InfoView {
        id: infoView
    }
    */


//    DetailsView {
//        id: detailsView
//    }


    //This can be ignored
    /*MoviesModel {
        id: moviesModel
    }
    */


    FpsItem {
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
    }



    PowerButton{}


    Clock{}

    AudioIndic{}


    WifiIndic{}

    CameraOptions{}

//    /*
//    BlueIndic{
//        width:100; height: 34
//        anchors.top: parent.top
//        anchors.topMargin: 10
//        anchors.right: parent.right
//        anchors.rightMargin: 50
//    }
//    */
}




//Rectangle {
////    color: "black"
//    width: 1280
//    height: 720

//    CustomOpenCVItem {
//        id: testCustomOpenCVItem
//        anchors.fill: parent
//        cameraID: 0
//        activateVideo: true
//        activateFaceRecognition: false
//        //property string myColor: "green"
////        x: 100
////        y: 100
//        //anchors.centerIn: parent
////        width: 640
////        height: 480
////        color: "green"

////        onReadySignal: {
////            color = "blue"
////        }

////        onReadyChanged: {
////            readyStatus.text = value;
////        }

////        MouseArea {
////            anchors.fill: parent
////            onClicked: {
//////                Qt.quit();
////                parent.color = 'red';
////            }
////        }
//    }

//    Text {
//        id: readyStatus
//        text: "Hello world"
//        font.pixelSize: 32
//    }
//}

