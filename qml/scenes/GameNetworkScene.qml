import QtQuick 2.0
import VPlay 2.0
import "../common"

KrkScene {
    id: scene

    property alias gameNetworkView: gameNetworkView

    VPlayGameNetworkView {
        id: gameNetworkView
        anchors.fill: scene.gameWindowAnchorItem

        onBackClicked: {
            scene.backButtonPressed()
        }
    }

    Connections {
        target: nativeUtils
        onTextInputFinished: {
            if(accepted) {
                var validUserName = gameNetwork.updateUserName(enteredText)
            }
        }
    }
}

