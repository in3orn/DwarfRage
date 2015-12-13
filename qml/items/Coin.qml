import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "barrel"

    width: 20
    height: 20

    property bool alive: true

    Rectangle {
        id: rect
        color: "white"

        anchors.centerIn: collider

        width: 20
        height: 20
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
        linearDamping: 0.5
        angularDamping: 0.5

        fixture.onBeginContact: alive = false
    }

    function init() {
        alive = true;

        collider.angularVelocity = 0;
        collider.linearVelocity = Qt.point(0, 0);
    }

    Component.onCompleted: init();
}
