import VPlay 2.0
import QtQuick 2.0

import "common"
import "scenes"

Item {
    id: mainItem

    property alias storage: storage
    property alias audioManager: audioManager
    property alias entityManager: entityManager
    property alias customFont: customFont

    property int highscore: gameNetwork.userHighscoreForCurrentActiveLeaderboard

    property string previousScene

    AudioManager {
        id: audioManager
    }

    BackgroundMusic {
        id: music
        source: "../assets/music/dummy.wav"
        muted: !settings.musicEnabled
    }

    FontLoader {
        id: customFont
        source: "../assets/font/ariblk.ttf"
    }

    /*
    Chartboost {
        id: chartboost

        appId:  "562c8f6904b0166e408f9898"
        appSignature:  "57bc72a0806cdfda796d0626875451fcbd71d04e"

        shouldDisplayInterstitial: false
        shouldDisplayRewardedVideo: true
        shouldPrefetchVideoContent: true

        onRewardedVideoCached: {
            console.debug("[Chartboost]: Video cached at location:", location)
        }

        onRewardedVideoFailedToLoad: {
            console.debug("[Chartboost]: Video failed to load at location:", location, "error:", error)
        }

        onRewardedVideoCompleted: {
            storage.adsWatched++
            gameNetwork.incrementAchievement("Supporter")
            gameNetwork.incrementAchievement("Contributor")
            gameNetwork.incrementAchievement("Patron")
        }

        Component.onCompleted: {
            console.debug("[Chartboost]: Start caching video")
            chartboost.cacheRewardedVideo()
        }
    }*/

    Settings {
        id: settings
    }

    KrkNetwork {
        id: gameNetwork
        gameNetworkView: gameNetworkScene.gameNetworkView
        //facebookItem: facebook
    }

    EntityManager {
        id: entityManager
        entityContainer: gameScene.entityContainer
    }

    KrkStorage {
        id: storage

        /*
        onTwitterUnlockedChanged: {
            gameScene.achievementDialog.itemImage = "../../assets/img/items/chopper_saber_red.png"
            gameScene.achievementDialog.itemText = qsTr("chopper")
            gameScene.achievementDialog.state = "shown"
        }*/
    }

    MenuScene {
        id: menuScene

        onPlayPressed: mainItem.state = "game"

        onGameNetworkPressed: {
            previousScene = "menu"
            mainItem.state = "gameNetwork"
        }

        onBackButtonPressed: {
            nativeUtils.displayMessageBox("Really quit the game?", "", 2);
        }

        Connections {
            target: window.activeScene === menuScene ? nativeUtils : null
            onMessageBoxFinished: {
                if(accepted) {
                    Qt.quit()
                }
            }
        }
    }

    GameScene {
        id: gameScene

        onBackButtonPressed: mainItem.state = "menu"
    }

    GameNetworkScene {
        id: gameNetworkScene
        onBackButtonPressed: {
            mainItem.state = previousScene
        }
    }

    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        },
        State {
            name: "gameNetwork"
            PropertyChanges {target: gameNetworkScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameNetworkScene}
        }
    ]
}

