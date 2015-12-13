import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "ground"

    width: 320
    height: 1920

    BackgroundImage {
        id: image

        source: "../../assets/img/game/ground.png"

        x: -width/2
        y: -height/2

        width: parent.width
        height: parent.height

        fillMode: Image.Tile
    }
}

