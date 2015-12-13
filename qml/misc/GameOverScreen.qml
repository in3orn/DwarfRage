import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1

Item {
    id: item

    signal playClicked()
    signal exitClicked()

    anchors.fill: parent

    enabled: opacity > 0
    opacity: 0

    property int score: 0

    ColumnLayout {
        anchors.centerIn: parent

        Text {
            id: title
            text: item.getTitle()
            font.pixelSize: 48
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: score
            text: qsTr("Your score: ") + item.score
            font.pixelSize: 32
            color: "white"
            Layout.alignment: Qt.AlignHCenter
        }

        KrkTextButton {
            id: playButton
            text: qsTr("Retry")
            onClicked: playClicked()
            Layout.alignment: Qt.AlignHCenter
        }

        KrkTextButton {
            id: exitButton
            text: qsTr("Back")
            onClicked: exitClicked()
            Layout.alignment: Qt.AlignHCenter
        }
    }

    states: [
        State {
            name: "shown"
            PropertyChanges {
                target: item; opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "shown"
            reversible: true

            animations:
                NumberAnimation {
                target: item
                property: "opacity"
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
    ]

    function getTitle() {
        if(item.score < 500) return qsTr("Keep trying");
        if(item.score < 1000) return qsTr("Not bad!");
        if(item.score < 2500) return qsTr("Nice!");
        if(item.score < 5000) return qsTr("Excelent!");
        if(item.score < 10000) return qsTr("OUTSTANGING!");

        return qsTr("UNBELIEVABLE!");
    }
}

