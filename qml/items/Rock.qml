import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "rock"

    width: 80
    height: 40

    minRage: 50
    rageGain: -minRage

    AnimatedSpriteVPlay {
        id: sprite
        paused: true

        source: "../../assets/img/game/rock.png"

        frameCount: 2
        frameRate: 0

        frameWidth: 80
        frameHeight: 40

        currentFrame: alive ? 0 : 1

        anchors.centerIn: collider
    }

    onAliveChanged: {
        audioManager.playRockSfx();
    }

    function init() {
        alive = true;
    }
}
