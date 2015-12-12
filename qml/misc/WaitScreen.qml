import VPlay 2.0
import QtQuick 2.0

Item {
    id: item

    signal activated()

    anchors.fill: parent

    enabled: opacity > 0
    opacity: 0

    Text {
        id: title
        text: qsTr("Tap to play")
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: item.activated()
    }

    states: [
        State {
            name: "shown"
            PropertyChanges {
                target: item; opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "shown"
            reversible: true

            animations:
                NumberAnimation {
                target: item
                property: "opacity"
                duration: 250
                easing.type: Easing.InOutQuad
            }
        }
    ]
}

