//
//  Sound.swift
//  JankenWithToshiko
//
//  Created by Juri Ohto on 2021/06/10.
//

import UIKit
import AVFoundation

var shortClickSound = Bundle.main.bundleURL.appendingPathComponent("bubble.mp3")
var shortClickSoundPlayer = AVAudioPlayer()

var backGroundSound = Bundle.main.bundleURL.appendingPathComponent("undersea.mp3")
var backGroundSoundPlayer = AVAudioPlayer()


func buttonTappedSoundPlay() {
    
    do {
        shortClickSoundPlayer = try AVAudioPlayer(contentsOf: shortClickSound, fileTypeHint: nil)
        shortClickSoundPlayer.volume = 1.0
        shortClickSoundPlayer.prepareToPlay()
        shortClickSoundPlayer.play()
    } catch let err {
        print("クリック音の読み込みに失敗しました。", err)
    }

}

func backGroundSoundPlay() {
    
    do {
        backGroundSoundPlayer = try AVAudioPlayer(contentsOf: backGroundSound, fileTypeHint: nil)
        backGroundSoundPlayer.numberOfLoops = -1 //無限ループ再生させる
        backGroundSoundPlayer.prepareToPlay() //音楽をバッファに読み込む
        backGroundSoundPlayer.play()
    } catch let err {
        print("BGMの読み込みに失敗しました", err)
    }

}


