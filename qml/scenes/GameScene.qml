import VPlay 2.0
import QtQuick 2.0

import "../items"
import "../misc"

import "../logic/GameLogic.js" as GameLogic

KrkScene {
    id: scene

    property int distance: -dwarf.y / 10
    property int bonus: 0

    property real spawnDist: -480
    property real spawnDiff: 480
    property int spawnType: 0

    EntityManager {
        id: entityManager
        entityContainer: container
    }

    focus: true

    Keys.onPressed: {
        if(scene.state === "wait") {
            scene.state = "play"
            event.accepted = true;
            return;
        }

        if(scene.state === "play") {
            if (event.key === Qt.Key_Left || event.key === Qt.Key_A) {
                dwarf.moveLeft();
                event.accepted = true;
            }
            if (event.key === Qt.Key_Right || event.key === Qt.Key_D) {
                dwarf.moveRight();
                event.accepted = true;
            }
        }
    }

    Keys.onReleased:  {
        if(scene.state === "play") {
            if (event.key === Qt.Key_Left || event.key === Qt.Key_A ||
                event.key === Qt.Key_Right || event.key === Qt.Key_D) {
                dwarf.release();
                event.accepted = true;
            }
        }
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

                debugDrawVisible: false
            }

            Repeater {
                id: grounds
                model: 2

                property real diffY: 480
                property real dy: model*diffY

                property int curr: 0

                Ground {
                    x: 160
                    y: -index * height
                }
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

                GoblinGuard { }
            }

            Repeater {
                id: goblinCowards
                model: 10

                property int curr: 0

                GoblinCoward { }
            }

            Repeater {
                id: bricks
                model: 30

                property int curr: 0

                Brick {}
            }

            Repeater {
                id: woods
                model: 10

                property int curr: 0

                Wood {}
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
                id: levelGates
                model: 2

                property int curr: 0

                LevelGate { }
            }

            Repeater {
                id: levelWalls
                model: 4

                property int curr: 0

                SideWall { }
            }

            Repeater {
                id: leftWalls
                model: 2

                property real diffY: 480
                property real dy: model*diffY

                property int curr: 0

                Wall {
                    x: 0
                    y: -index * height
                }
            }

            Repeater {
                id: rightWalls
                model: 2

                property real diffY: 480
                property real dy: model*diffY

                property int curr: 0

                Wall {
                    x: 320
                    y: -index * height
                }
            }

            Dwarf {
                id: dwarf
                onOwned: {
                    gameNetwork.reportScore(distance + bonus);
                    scene.state = "gameOver"
                }

                onYChanged: {
                    GameLogic.updatePosition(grounds, dwarf.y);
                    GameLogic.updatePosition(leftWalls, dwarf.y);
                    GameLogic.updatePosition(rightWalls, dwarf.y);

                    if(dwarf.y - spawnDist < 480) {
                        spawnDist -= spawnDiff;
                        if(spawnDiff > 120) spawnDiff -= 0.25;

                        spawnType++;
                        spawnType %= 12;

                        spawnObstacles();

                        if(Math.random() < 0.5) {
                            spawnGoblinCoward();
                        }
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

        GameOverScreen {
            id: gameOverScreen

            score: distance + bonus

            anchors.centerIn: parent

            onPlayClicked: scene.state = "play";
            onExitClicked: backButtonPressed();
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
            text: qsTr("Discance: " + distance)
            color: "white"

            anchors {
                top: parent.top
                left: parent.left
                margins: mm
                leftMargin: 80 + mm
            }
        }

        Text {
            id: bonusText
            text: qsTr("Bonus: " + bonus)
            color: "white"

            anchors {
                top: parent.top
                right: parent.right
                margins: mm
                rightMargin: 120 + mm
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
            name: "gameOver"
            PropertyChanges { target: gameOverScreen; state: "shown" }
        },
        State {
            name: "play"
            StateChangeScript {
                script: {
                    initGame();
                    dwarf.release();
                }
            }
        }
    ]

    function initGame() {
        bonus = 0;

        spawnDist = -480;
        spawnDiff = 480;
        spawnType = 0;

        dwarf.init();

        for(var i = 0; i < grounds.model; i++)
            grounds.itemAt(i).y = -i * grounds.diffY;

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

        spikes.curr = 0;
        for(var i = 0; i < spikes.model; i++)
            spikes.itemAt(i).y = 480;

        goblins.curr = 0;
        for(var i = 0; i < goblins.model; i++)
            goblins.itemAt(i).y = 480;

        goblinCowards.curr = 0;
        for(var i = 0; i < goblinCowards.model; i++)
            goblinCowards.itemAt(i).y = 480;

        levelWalls.curr = 0;
        for(var i = 0; i < levelWalls.model; i++)
            levelWalls.itemAt(i).y = 480;

        levelGates.curr = 0;
        for(var i = 0; i < levelGates.model; i++)
            levelGates.itemAt(i).y = 480;

        coins.curr = 0;
        for(var i = 0; i < coins.model; i++)
            coins.itemAt(i).init();

        bricks.curr = 0;
        for(var i = 0; i < bricks.model; i++)
            bricks.itemAt(i).init();

        woods.curr = 0;
        for(var i = 0; i < woods.model; i++)
            woods.itemAt(i).init();
    }

    function spawnObstacles() {
        switch(spawnType) {
        case 0:
            spawnLevelWalls();
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

    function spawnLevelWalls() {
        spawnLevelWall(true);
        spawnLevelWall(false);
        spawnLevelGate();

        for(var i = 0; i < 3; i += 0.5) {
            spawnItem(bricks, i);
            spawnItem(bricks, i);
        }

        for(var i = 4; i < 7; i += 0.5) {
            spawnItem(bricks, i);
            spawnItem(bricks, i);
        }

        for(var i = 2.5; i < 5; i += 0.5) {
            spawnItem(woods, i);
            spawnItem(woods, i);
        }
    }

    function spawnLevelWall(left) {
        var item = levelWalls.itemAt(levelWalls.curr);
        item.init();

        var pos = left ? 60 : 260;
        item.x = pos;
        item.y = spawnDist;

        levelWalls.curr++;
        levelWalls.curr %= levelWalls.model;
    }

    function spawnLevelGate() {
        var item = levelGates.itemAt(levelGates.curr);
        item.init();

        item.x = 160;
        item.y = spawnDist;

        levelGates.curr++;
        levelGates.curr %= levelGates.model;
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

    function spawnSideBiggerItem(items) {
        var item = items.itemAt(items.curr);
        item.init();

        var pos = Math.random() < 0.5 ? 60 : 260;
        item.x = pos;
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

    function spawnGoblinCoward() {
        var item = goblinCowards.itemAt(goblinCowards.curr);
        item.init();

        var pos = Math.round(5.0 * Math.random());
        item.x = 60 + 40*pos;
        item.y = spawnDist+240;
        item.release();

        goblinCowards.curr++;
        goblinCowards.curr %= goblinCowards.model;
    }

    Component.onCompleted: initGame();
}

