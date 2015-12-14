import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "dwarf"

    width: 40
    height: 40

    readonly property real vx: 200
    readonly property real vy: 200

    property real rage: 40

    property bool alive: true

    property int minRage: 0
    property int rageGain: 20

    signal owned()

    SpriteSequenceVPlay {
        id: animation

        defaultSource: "../../assets/img/game/goblin_running.png"

        anchors.centerIn: collider

        SpriteVPlay {
            name: "walk"
            frameWidth: 40
            frameHeight: 40
            frameCount: 4
            startFrameColumn: 1
            frameRate: 20
            to: {"walk": 1}
        }
        SpriteVPlay {
            name: "whirl"
            frameWidth: 40
            frameHeight: 40
            frameCount: 2
            startFrameColumn: 14
            frameRate: 20
            to: {"walk": 1}
        }
        SpriteVPlay {
            name: "jump"
            frameWidth: 40
            frameHeight: 40
            frameCount: 4
            startFrameColumn: 5
            frameRate: 10
            to: {"whirl": 1}
        }
        SpriteVPlay {
            name: "die"
            frameWidth: 40
            frameHeight: 40
            frameCount: 3
            startFrameColumn: 10
            frameRate: 10
            to: {"dieLastFrame": 1}
        }
        SpriteVPlay {
            name: "dieLastFrame"
            startFrameColumn: 12
            frameWidth: 40
            frameHeight: 40
            to: {"dieLastFrame": 1}
        }
    }

    CircleCollider {
        id: collider

        categories: Box.Category1
        collidesWith: alive ? Box.Category1 | Box.Category2 : Box.Category2

        bodyType: Body.Dynamic
        radius: width/2

        x: -radius
        y: -radius

        fixedRotation: true
        restitution: 1
        density: 1
        linearDamping: alive ? 0 : 5

        fixture.onBeginContact: {
            var body = other.getBody();
            var item = body.target;

            if(item.minRage !== undefined && alive) {
                if(rage >= item.minRage) {
                    animation.jumpTo("jump");
                }
                else {
                    if(Math.abs(dwarf.y-parent.y) < 240) {
                        audioManager.playGoblinSfx();
                    }
                    alive = false;
                }
            }
        }
    }

    function release() {
        if(alive)
            collider.linearVelocity = Qt.point(0, -vy-rage);
    }

    onAliveChanged: {
        if(!alive) {
            animation.jumpTo("die");

            rage = 0;
            owned();
        } else {
            animation.jumpTo("walk")
        }
    }

    onRageChanged: {
        if(alive) {
            animation.jumpTo("jump");

            var old = collider.linearVelocity;
            collider.linearVelocity = Qt.point(old.x, -vy-rage);
        }
    }

    function init() {
        alive = true;
        rage = 50;

        collider.linearVelocity = Qt.point(0, 0);

        x = parent.width/2;
        y = 0;
    }

    Component.onCompleted: init();
}
