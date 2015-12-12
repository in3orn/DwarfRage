import VPlay 2.0
import QtQuick 2.0

Item {
    id: audioManager

    property bool muted: !settings.soundEnabled

    function playSwingSfx() {
        if(muted) return
        sound.play()
    }

    SoundEffectVPlay {
        id: sound
        source: "../../assets/sound/sfx_swing.wav"
        muted: audioManager.muted
    }
}

