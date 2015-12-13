import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "sideWall"

    z: 1

    width: 120
    height: 40

    minRage: 100
    rageGain: -minRage

    BackgroundImage {
        id: image

        source: "../../assets/img/game/sidewall.png"

        anchors.fill: collider
        fillMode: Image.Tile
    }

    function init() {
        alive = true;
    }
}
