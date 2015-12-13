import VPlay 2.0
import QtQuick 2.0

CircleItem {
    id: item
    entityType: "goblin"

    width: 40
    height: 40

    minRage: 0
    rageGain: 20

    Rectangle {
        id: rect

        width: 40
        height: 40
        radius: 20

        anchors.centerIn: collider

        color: "green"
    }

    onAliveChanged: rect.color = "red"

    function init() {
        alive = true;
        rect.color = "green"
    }

    Component.onCompleted: init();
}
