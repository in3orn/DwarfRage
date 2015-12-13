import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "wood"

    width: 50
    height: 10

    property bool alive: true

    MultiResolutionImage {
        id: image

        source: "../../assets/img/game/wood.png"

        anchors.centerIn: collider
    }

    BoxCollider {
        id: collider

        categories: Box.Category4
        collidesWith: alive ? Box.Category1 : ~Box.Category1 & ~Box.Category4

        bodyType: Body.Dynamic

        x: -width/2
        y: -height/2

        density: 0.05
        restitution: 0.5
        friction: 0.8
        linearDamping: 3
        angularDamping: 3

        fixture.onBeginContact: {
            audioManager.playWoodSfx();
            alive = false
        }
    }

    function init() {
        alive = true;

        collider.angularVelocity = 0;
        collider.linearVelocity = Qt.point(0, 0);
    }

    Component.onCompleted: init();
}
