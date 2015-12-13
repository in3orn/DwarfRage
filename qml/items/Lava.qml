import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: item
    entityType: "lava"

    property bool alive: true

    property int minRage: 1000
    property int rageGain: -minRage

    property alias collider: collider

    width: 80
    height: 80

    AnimatedSpriteVPlay {
        id: sprite

        source: "../../assets/img/game/lava.png"

        frameCount: 8
        frameRate: 10

        frameWidth: 80
        frameHeight: 80

        anchors.centerIn: collider
    }

    BoxCollider {
        id: collider

        x: -width/2
        y: -height/2

        categories: Box.Category2
        collidesWith: Box.Category1

        bodyType: Body.Static
        collisionTestingOnlyMode: true
    }

    function init() {
    }
}
