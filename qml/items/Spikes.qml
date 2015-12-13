import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "spikes"

    width: 40
    height: 40

    minRage: 10
    rageGain: -minRage

    Rectangle {
        id: rect

        width: 40
        height: 40

        anchors.centerIn: collider

        color: "yellow"
    }

    onAliveChanged: rect.color = "red"

    function init() {
        alive = true;
        rect.color = "green"
    }

    Component.onCompleted: init();
}
