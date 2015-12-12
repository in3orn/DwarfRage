import VPlay 2.0
import QtQuick 2.0

VPlayGameNetwork {
    gameId: 191
    secret: "YouAreNotABloodyPirate57!"

    //clearAllUserDataAtStartup: true

    onNewHighscore: {
        if(!isUserNameSet(userName)) {
            nativeUtils.displayTextInput("Congratulations!",
            "You achieved a new highscore. Enter your name for comparing scores?", "")
        }
    }

    /*
    achievements: [
        Achievement {
            key: "ChoppingAdept"
            name: "Chopping Adept"
            description: "Chop 500 suchi chunks"
            target: 500
            points: 50
            iconSource: "../../assets/img/achievements/chopping_adept.png"
        }
    ]*/

    function isAchievementUnlocked(name) {
        var achievement = getAchievementFromKey(name)
        return achievement !== undefined && achievement.unlocked
    }
}

