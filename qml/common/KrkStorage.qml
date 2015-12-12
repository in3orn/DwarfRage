import VPlay 2.0
import QtQuick 2.0

WebStorage {
    id: storage

    //clearAllAtStartup: true
    //clearAllLocallyAtStartup: true

    // Thresholds
    readonly property int scoreThreshold: 500

    // Unlocked
    property bool scoreUnlocked: score >= scoreThreshold

    // Parameters
    property int score: 0

    function load() {
        score = loadProperty("score")
    }

    function loadProperty(name) {
        var stored = getValue(name)
        return stored !== undefined ? stored : 0
    }

    function save() {
        setValue("score", score)
    }

    Component.onCompleted: load()

    Component.onDestruction: save()
}

