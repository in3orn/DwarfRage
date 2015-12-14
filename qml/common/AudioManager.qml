import VPlay 2.0
import QtQuick 2.0

Item {
    id: audioManager

    property bool muted: !settings.soundEnabled

    function playDieSfx() {
        if(muted) return;
        if(Math.random() < 0.5) die0.play()
        else die1.play();
    }

    function playRageSfx() {
        if(muted) return;
        if(Math.random() < 0.5) rage0.play()
        else rage1.play();
    }

    function playGoblinSfx() {
        if(muted) return;
        var r = Math.random();
        if(r < 0.33) goblin0.play()
        else if(r < 0.66) goblin1.play();
        else goblin2.play();
    }

    function playBarrelSfx() {
        if(muted) return;
        barrel.play();
    }

    function playLavaSfx() {
        if(muted) return;
        lava.play();
    }

    function playGateSfx() {
        if(muted) return;
        gate.play();
    }

    function playRockSfx() {
        if(muted) return;
        rock.play();
    }

    function playWoodSfx() {
        if(muted) return;
        wood.play();
    }

    SoundEffectVPlay {
        id: die0
        source: "../../assets/sound/die_0.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: die1
        source: "../../assets/sound/die_1.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: rage0
        source: "../../assets/sound/rage_0.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: rage1
        source: "../../assets/sound/rage_1.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: goblin0
        source: "../../assets/sound/goblin_0.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: goblin1
        source: "../../assets/sound/goblin_1.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: goblin2
        source: "../../assets/sound/goblin_2.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: barrel
        source: "../../assets/sound/barrel.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: lava
        source: "../../assets/sound/lava.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: gate
        source: "../../assets/sound/gate.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: rock
        source: "../../assets/sound/rock.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: wood
        source: "../../assets/sound/wood.wav"
        muted: audioManager.muted
    }
}

