import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "wall"

    width: 20

    BackgroundImage {
        id: image

        source: "../../assets/img/misc/sidewall.png"

        anchors.fill: collider
        fillMode: Image.Tile
    }

    BoxCollider {
        id: collider

        x: -parent.width/2
        y: -parent.height/2

        categories: Box.Category2
        bodyType: Body.Static
        restitution: 1
    }
}

