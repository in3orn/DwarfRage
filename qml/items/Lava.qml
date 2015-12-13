import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: item

    property bool alive: true

    property int minRage: 1000
    property int rageGain: -minRage

    property alias collider: collider

    width: 80
    height: 80

    Rectangle {
        id: rect

        anchors.centerIn: collider

        width: parent.width
        height: parent.height

        color: "red"
    }

    BoxCollider {
        id: collider

        x: -width/2
        y: -height/2

        categories: Box.Category2
        collidesWith: Box.Category1

        bodyType: Body.Static
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            console.debug("[Lava]")
        }
    }

    function init() {

    }
}
