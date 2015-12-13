import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: item

    property bool alive: true

    property int minRage: 0
    property int rageGain: 0

    property alias collider: collider

    BoxCollider {
        id: collider

        x: -width/2
        y: -height/2

        categories: Box.Category2
        collidesWith: Box.Category1

        bodyType: Body.Static
        collisionTestingOnlyMode: !alive || minRage <= dwarf.rage
    }

    BoxCollider {
        id: collider2

        x: -width/2
        y: -height/2

        categories: Box.Category3
        collidesWith: ~Box.Category1

        bodyType: Body.Static
    }
}
