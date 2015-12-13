import VPlay 2.0
import QtQuick 2.0

CircleItem {
    id: item
    entityType: "barrel"

    width: 40
    height: 40

    minRage: 20
    rageGain: -minRage

    Rectangle {
        id: rect

        width: 40
        height: 40

        anchors.centerIn: collider

        color: "brown"
    }

    onAliveChanged: rect.color = "red"

    function init() {
        alive = true;
        rect.color = "green"
    }

    Component.onCompleted: init();
}
