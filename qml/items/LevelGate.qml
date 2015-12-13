import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "levelGate"

    z: 1
    width: 80
    height: 40

    minRage: 20
    rageGain: -minRage

    MultiResolutionImage {
        id: light

        source: "../../assets/img/game/gate_light.png"

        anchors.centerIn: collider
    }

    BackgroundImage {
        id: image

        source: "../../assets/img/game/sidewall.png"

        anchors.centerIn: collider
        fillMode: Image.Tile

        width: 120
    }

    onAliveChanged: {
        if(Math.abs(dwarf.y-parent.y) < 100) {
            audioManager.playGateSfx();
        }
    }

    function init() {
        alive = true;
    }
}
