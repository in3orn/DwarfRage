import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "rock"

    width: 80
    height: 80

    minRage: 50
    rageGain: -minRage

    Rectangle {
        id: rect

        anchors.centerIn: collider

        width: parent.width
        height: parent.height

        color: "yellow"
    }

    onAliveChanged: {
        audioManager.playRockSfx();
    }

    function init() {
        alive = true;
    }
}
