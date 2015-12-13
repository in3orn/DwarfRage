import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "sideWall"

    width: 120
    height: 80

    minRage: 100
    rageGain: -minRage

    Rectangle {
        id: rect

        anchors.centerIn: collider

        width: parent.width
        height: parent.height

        color: "grey"
    }

    onAliveChanged: rect.color = "black"

    function init() {
        alive = true;
        rect.color = "grey"
    }
}
