import VPlay 2.0
import QtQuick 2.0

CircleItem {
    id: item
    entityType: "barrel"

    width: 40
    height: 40

    minRage: 20
    rageGain: -minRage

    AnimatedSpriteVPlay {
        id: sprite
        paused: true

        source: "../../assets/img/game/barrel.png"

        frameCount: 2
        frameRate: 0

        frameWidth: 65
        frameHeight: 105

        currentFrame: alive ? 0 : 1

        anchors.centerIn: collider
    }

    onAliveChanged: {
        audioManager.playBarrelSfx();
    }

    function init() {
        alive = true;
    }

    Component.onCompleted: init();
}
