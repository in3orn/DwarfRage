import VPlay 2.0
import QtQuick 2.0

Rectangle {
    id: progressBar

    property string text: qsTr("Loading...")
    property real progress: 0

    property alias frontColor: progressBarFront.color

    width: 100
    height: 20

    color: "white"
    border {
        width: 2
        color: "#333333"
    }

    Text {
        id: progressBarText
        text: progressBar.text
        color: "#333333"
        anchors.centerIn: parent
    }

    Rectangle {
        id: progressBarFront

        width: parent.width * progressBar.progress
        height: parent.height

        color: "#333333"

        clip: true

        Text {
            id: progressBarFrontText
            text: progressBar.text
            color: "white"
            x: progressBarText.x
            y: progressBarText.y
        }
    }
}
