import VPlay 2.0
import QtQuick 2.0

CircleItem {
    id: item
    entityType: "goblin"

    width: 40
    height: 40

    minRage: 0
    rageGain: 20

    AnimatedSpriteVPlay {
        id: sprite
        paused: true

        source: "../../assets/img/game/goblin_static.png"

        frameCount: 2
        frameRate: 0

        frameWidth: 40
        frameHeight: 40

        currentFrame: alive ? 0 : 1

        anchors.centerIn: collider
    }

    onAliveChanged: {
        audioManager.playGoblinSfx();
    }

    function init() {
        alive = true;
    }

    Component.onCompleted: init();
}
