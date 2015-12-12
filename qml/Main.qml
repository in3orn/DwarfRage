import VPlay 2.0
import QtQuick 2.0

import "scenes"

GameWindow {
    id: gameWindow

    width: 320
    height: 480

    activeScene: splash

    //licenseKey: ""

    property alias window: gameWindow

    Component.onCompleted: {
        splash.opacity = 1
        mainItemDelay.start()
    }

    Timer {
        id: mainItemDelay
        interval: 500
        onTriggered: {
            mainItemLoader.source = "MainItem.qml"
        }
    }

    Loader {
        id: mainItemLoader
        onLoaded: if(item) hideSplashDelay.start()
    }

    Timer {
        id: hideSplashDelay
        interval: 200
        onTriggered: {
            splash.opacity = 0
        }
    }

    SplashScene {
        id: splash
    }
}

