import VPlay 2.0
import QtQuick 2.0

EntityBase {
    entityType: "dwarf"

    width: 40
    height: 40

    readonly property real vx: 200
    readonly property real vy: 200

    readonly property real maxRage: 400
    property real rage: 0

    property bool alive: true

    signal owned()

    SpriteSequenceVPlay {
        id: animation

        defaultSource: "../../assets/img/game/dwarf.png"

        anchors.centerIn: collider

        SpriteVPlay {
            name: "walk"
            frameWidth: 32
            frameHeight: 32
            frameCount: 4
            startFrameColumn: 1
            frameRate: 20
            to: {"walk": 1}
        }
        SpriteVPlay {
            name: "whirl"
            frameWidth: 32
            frameHeight: 32
            frameCount: 2
            startFrameColumn: 14
            frameRate: 20
            to: {"walk": 1}
        }
        SpriteVPlay {
            name: "jump"
            frameWidth: 32
            frameHeight: 32
            frameCount: 4
            startFrameColumn: 5
            frameRate: 10
            to: {"whirl": 1}
        }
        SpriteVPlay {
            name: "die"
            frameWidth: 32
            frameHeight: 32
            frameCount: 3
            startFrameColumn: 10
            frameRate: 10
            to: {"dieLastFrame": 1}
        }
        SpriteVPlay {
            name: "dieLastFrame"
            startFrameColumn: 12
            frameWidth: 32
            frameHeight: 32
            to: {"dieLastFrame": 1}
        }
    }

    CircleCollider {
        id: collider

        categories: Box.Category1

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
                    item.alive = false;
                    rage += item.rageGain;
                    if(rage >= maxRage)
                        rage = maxRage;

                    //TODO should not be here!
                    gameScene.bonus += Math.abs(item.rageGain);
                }
                else {
                    audioManager.playDieSfx();
                    alive = false;
                }
            }
        }
    }

    function moveLeft() {
        if(alive)
            collider.linearVelocity = Qt.point(-vx-rage, -vy-rage);
    }

    function moveRight() {
        if(alive)
            collider.linearVelocity = Qt.point(vx+rage, -vy-rage);
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
            audioManager.playRageSfx();
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
