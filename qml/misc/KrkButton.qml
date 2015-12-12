import VPlay 2.0
import QtQuick 2.0

Item {
    id: button

    signal clicked
    signal pressed
    signal released

    width: sprite.width
    height: sprite.height

    property alias source: sprite.source

    MultiResolutionImage {
        id: sprite
    }

    MouseArea {
        id: mouseArea
        enabled: button.enabled
        anchors.fill: button
        hoverEnabled: true

        onClicked: {
          button.scale = 1.0
          button.clicked()
        }
        onPressed: {
          button.scale = 0.85
        }
        onReleased: {
          button.scale = 1.0
        }
        onCanceled: {
          button.scale = 1.0
        }
    }
}

