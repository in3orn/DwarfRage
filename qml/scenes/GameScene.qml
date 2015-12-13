import VPlay 2.0
import QtQuick 2.0

import "../items"
import "../misc"

import "../logic/GameLogic.js" as GameLogic

KrkScene {
    id: scene

    property int distance: -dwarf.y / 10

    property real spawnDist: -480
    property real spawnDiff: 960
    property int spawnType: 0

    EntityManager {
        id: entityManager
        entityContainer: container
    }

    Rectangle {
        anchors.fill: scene.gameWindowAnchorItem
        color: "black"

        MouseArea {
            id: leftButton
            z: 1

            width: parent.width/2
            height: parent.height
            anchors.left: parent.left

            onPressed: dwarf.moveLeft();
            onReleased: dwarf.release();
        }

        MouseArea {
            id: rightButton
            z: 1

            width: parent.width/2
            height: parent.height
            anchors.right: parent.right

            onPressed: dwarf.moveRight();
            onReleased: dwarf.release();
        }
    }

    Item {
        id: main
        width: 480
        height: 480

        clip: true

        anchors.centerIn: parent

        Item {
            id: container
            transformOrigin: Item.Center

            x: main.width/2 - dwarf.x
            y: main.height/2 - dwarf.y

            width: 320

            PhysicsWorld {
                id: physicsWorld
                gravity: Qt.point(0,0)
            }

            Repeater {
                id: lavas
                model: 10

                property int curr: 0

                Lava { }
            }

            Repeater {
                id: barrels
                model: 30

                property int curr: 0

                Barrel { }
            }

            Repeater {
                id: spikes
                model: 30

                property int curr: 0

                Spikes { }
            }

            Repeater {
                id: goblins
                model: 30

                property int curr: 0

                Goblin { }
            }

            Repeater {
                id: coins
                model:30

                property int curr: 0

                Repeater {
                    model: 5
                    Coin { }

                    function init(num) {
                        for(var i = 0; i < model; i++) {
                            var barrel = barrels.itemAt(num);

                            var item = itemAt(i);
                            item.x = barrel.x + Math.random() * (barrel.width - item.width)
                                    + item.width/2 - barrel.width/2;
                            item.y = barrel.y + Math.random() * (barrel.height - item.height)
                                    + item.height/2 - barrel.height/2;
                            item.init();
                        }
                    }
                }

                function init() {
                    for(var i = 0; i < model; i++)
                        itemAt(i).init(i);
                }
            }

            Repeater {
                id: rocks
                model: 10

                property int curr: 0

                Rock { }
            }

            Repeater {
                id: leftWalls
                model: 2

                property real diffY: 480
                property real dy: model*diffY

                property int curr: 0

                Wall {
                    x: 10
                    y: -index * height

                    height: leftWalls.diffY
                }
            }

            Repeater {
                id: rightWalls
                model: 2

                property real diffY: 480
                property real dy: model*diffY

                property int curr: 0

                Wall {
                    x: 310
                    y: -index * height

                    height: rightWalls.diffY
                }
            }

            Dwarf {
                id: dwarf
                onOwned: scene.state = "wait"

                onYChanged: {
                    GameLogic.updatePosition(leftWalls, dwarf.y);
                    GameLogic.updatePosition(rightWalls, dwarf.y);

                    if(dwarf.y - spawnDist < 480) {
                        spawnDist -= spawnDiff;
                        if(spawnDiff > 120) spawnDiff -= 0.5;

                        spawnType++;
                        spawnType %= 12;

                        spawnObstacles();
                    }
                }
            }
        }

        MultiResolutionImage {
            id: shadow

            source: "../../assets/img/misc/shadow.png"

            anchors.centerIn: parent
        }

        WaitScreen {
            id: waitScreen
            anchors.centerIn: parent

            onActivated: scene.state = "play"
        }

        KrkProgressBar {
            id: rageBar

            width: 300
            height: 40

            text: qsTr("My rage is growing!")
            color: "black"
            border.color: "#330000"
            frontColor: "#aa0000"

            progress: dwarf.rage / dwarf.maxRage

            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: mm
            }
        }

        Text {
            id: distanceText
            text: qsTr("Distance: " + distance)
            color: "white"

            anchors {
                top: parent.top
                left: parent.left
                margins: mm
                leftMargin: 80 + mm
            }
        }
    }

    state: "wait"

    states: [
        State {
            name: "wait"
            PropertyChanges { target: waitScreen; state: "shown" }
        },
        State {
            name: "play"
            //PropertyChanges { target: object }
            StateChangeScript { script: initGame() }
        }
    ]

    function initGame() {
        spawnDist = -480;
        spawnDiff = 240;
        spawnType = 0;

        dwarf.init();

        for(var i = 0; i < leftWalls.model; i++)
            leftWalls.itemAt(i).y = -i * leftWalls.diffY;

        for(var i = 0; i < rightWalls.model; i++)
            rightWalls.itemAt(i).y = -i * rightWalls.diffY;

        lavas.curr = 0;
        for(var i = 0; i < lavas.model; i++)
            lavas.itemAt(i).y = 480;

        rocks.curr = 0;
        for(var i = 0; i < rocks.model; i++)
            rocks.itemAt(i).y = 480;

        barrels.curr = 0;
        for(var i = 0; i < barrels.model; i++)
            barrels.itemAt(i).y = 480;

        coins.curr = 0;
        for(var i = 0; i < coins.model; i++)
            coins.itemAt(i).init();

        spikes.curr = 0;
        for(var i = 0; i < spikes.model; i++)
            spikes.itemAt(i).y = 480;

        goblins.curr = 0;
        for(var i = 0; i < goblins.model; i++)
            goblins.itemAt(i).y = 480;
    }

    function spawnObstacles() {
        switch(spawnType) {
        case 0:
            //level wall
            break;
        case 1:
        case 2:
        case 3:
        case 5:
        case 6:
        case 7:
        case 9:
        case 10:
        case 11:
            spawnItems(0.5);
            break;
        case 4:
            spawnBiggerItem(rocks);
            break;
        case 8:
            spawnBiggerItem(lavas);
            break;
        }
    }

    function spawnItems(p) {
        for(var i = 0; i < 7; i++) {
            if(Math.random() < p) {
                var r = Math.random();
                if(r < 0.5) spawnItem(goblins, i);
                else if(r < 0.75) spawnItem(spikes, i);
                else {
                    spawnItem(barrels, i);
                    updateCoins();
                }
            }
        }
    }

    function spawnItem(items, pos) {
        var item = items.itemAt(items.curr);
        item.init();

        item.x = 40 + 40*pos;
        item.y = spawnDist;

        items.curr++;
        items.curr %= items.model;
    }

    function spawnBiggerItem(items) {
        var item = items.itemAt(items.curr);
        item.init();

        var pos = Math.round(5.0 * Math.random());
        item.x = 60 + 40*pos;
        item.y = spawnDist;

        items.curr++;
        items.curr %= items.model;
    }

    function updateCoins() {
        var coin = coins.itemAt(coins.curr);
        coin.init(coins.curr);

        coins.curr++;
        coins.curr %= coins.model;
    }

    Component.onCompleted: initGame();
}

