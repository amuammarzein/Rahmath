//
//  Audio.swift
//  Rahmath
//
//  Created by Aang Muammar Zein on 03/04/23.
//
import AVFoundation
import Foundation

var playerSound: AVAudioPlayer!
var playerMusic: AVAudioPlayer!
var audioName = "backsound.mp3"

func stopMusic() {
    let url = Bundle.main.url(forResource: audioName, withExtension: nil)
    guard url != nil else {
        return
    }
    do {
        playerMusic = try AVAudioPlayer(contentsOf: url!)
        playerMusic.stop()
    } catch {
        print(error.localizedDescription)
    }
}

func playMusic() {
    let url = Bundle.main.url(forResource: audioName, withExtension: nil)
    guard url != nil else {
        return
    }
    do {
        playerMusic = try AVAudioPlayer(contentsOf: url!)
        playerMusic.prepareToPlay()
        playerMusic.numberOfLoops = -1
        playerMusic.play()

    } catch {
        print(error.localizedDescription)
    }
}

func stopSound() {
    playerSound.stop()
}

func playSound(audioName: String) {
    soundStatus = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
    if soundStatus == true {
        let url = Bundle.main.url(forResource: audioName, withExtension: nil)
        guard url != nil else {
            return
        }
        do {
            playerSound = try AVAudioPlayer(contentsOf: url!)
            playerSound.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}

var myQueuePlayer: AVQueuePlayer?

var avItems: [AVPlayerItem] = []

func playSoundMultiple(audioName: [String]) {
    soundStatus = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
    if soundStatus == true {
        avItems.removeAll()

        let items: [String] = audioName

        for clip in items {
            guard let url = Bundle.main.url(forResource: clip, withExtension: nil) else {
                fatalError("Could not load \(clip).mp3")
            }
            avItems.append(AVPlayerItem(url: url))
        }

        print(avItems)
        if myQueuePlayer == nil {
            myQueuePlayer = AVQueuePlayer(items: avItems)

        } else {
            myQueuePlayer?.removeAllItems()

            avItems.forEach {
                myQueuePlayer?.insert($0, after: nil)
            }
        }
        myQueuePlayer?.seek(to: .zero)
        myQueuePlayer?.play()
    }
}
