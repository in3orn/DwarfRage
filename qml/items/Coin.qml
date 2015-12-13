import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "barrel"

    width: 20
    height: 20

    property bool alive: true

    MultiResolutionImage {
        id: rect

        source: "../../assets/img/game/ball.png"

        anchors.centerIn: collider
    }

    CircleCollider {
        id: collider

        categories: Box.Category4
        collidesWith: alive ? Box.Category1 : ~Box.Category1

        bodyType: Body.Dynamic

        x: -parent.width/2
        y: -parent.height/2

        radius: 10

        density: 0.01
        restitution: 1
        friction: 0.2
        linearDamping: 5
        angularDamping: 5

        fixture.onBeginContact: {
            if(Math.abs(dwarf.y-parent.y) < 100) {
                audioManager.playRockSfx();
            }
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
