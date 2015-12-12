import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../misc"

KrkScene {
    id: scene

    signal playPressed()
    signal gameNetworkPressed()

    ColumnLayout {
        anchors.centerIn: parent

        KrkTextButton {
            id: playButton
            text: qsTr("Play");
            onClicked: playPressed()
        }

        KrkTextButton {
            id: gameNetworkButton
            text: qsTr("Scores");
            onClicked: gameNetworkPressed()
        }

        KrkTextButton {
            id: exitButton
            text: qsTr("Exit");
            onClicked: backButtonPressed()
        }
    }
}

