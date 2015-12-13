import VPlay 2.0
import QtQuick 2.0

BoxItem {
    id: item
    entityType: "rock"

    width: 80
    height: 80

    minRage: 100
    rageGain: -50

    Rectangle {
        id: rect

        anchors.centerIn: collider

        width: parent.width
        height: parent.height

        color: "yellow"
    }

    onAliveChanged: rect.color = "#330000"

    function init() {
        alive = true;
        rect.color = "yellow"
    }
}
