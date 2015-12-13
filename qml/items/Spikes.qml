import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "spikes"

    width: 40
    height: 40

    minRage: 10
    rageGain: -minRage

    AnimatedSpriteVPlay {
        id: sprite
        paused: true

        source: "../../assets/img/game/box.png"

        frameCount: 2
        frameRate: 0

        frameWidth: 40
        frameHeight: 80

        currentFrame: alive ? 0 : 1

        anchors.centerIn: collider
    }

    onAliveChanged: {
        audioManager.playWoodSfx();
    }

    function init() {
        alive = true;
    }

    Component.onCompleted: init();
}
