import QtQuick 2.0
import QtQuick.Particles 2.0

Item {
    id: root

    property alias text: textItem.text
    property alias text2: textItem2.text
    property bool checked: false
    property string onText: "On"
    property string offText: "Off"

    QtObject {
        id: priv
        property alias checkedPriv: root.checked
    }

    width: parent ? parent.width : 200
    height:  50

    /*
    MouseArea {
        width: parent.width
        height: parent.height
        onClicked: {
            root.checked = !root.checked
        }
    }
    */

    Text {
        id: textItem
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 22
        elide: Text.ElideRight
        font.pixelSize: 16
        color: "#ffffff"
    }

    Text {
        id: textItem2
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 22
        elide: Text.ElideRight
        font.pixelSize: 16
        color: "#ffffff"
    }
        
}
