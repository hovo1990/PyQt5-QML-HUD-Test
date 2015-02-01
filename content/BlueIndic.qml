import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    property int custom_width: 40
    property int custom_height: 40

    width: custom_width
    height: custom_height


    Image {
        id: bluetooth_image
        width: custom_width; height: custom_height
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "icons/bluetooth.png"
    }


    /*
    Desaturate {
        anchors.fill: bluetooth_image
        source: bluetooth_image
        desaturation: 0.8
    }
    */
}
