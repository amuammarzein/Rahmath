//
//  Audio.swift
//  Rahmath
//
//  Created by Aang Muammar Zein on 03/04/23.
//
import Foundation
import AVFoundation

var playerSound: AVAudioPlayer!
var playerMusic: AVAudioPlayer!
var file_name = "backsound.mp3"

func stopMusic(){
    let url = Bundle.main.url(forResource: file_name, withExtension: nil)
    guard url != nil else{
        return
    }
    do {
        playerMusic = try AVAudioPlayer(contentsOf: url!)
        playerMusic.stop()
    } catch {
        print(error.localizedDescription)
    }
    //    playerMusic.stop()
}
func playMusic(){
    let url = Bundle.main.url(forResource: file_name, withExtension: nil)
    guard url != nil else{
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

func stopSound(){
    playerSound.stop()
}


func playSound(file_name: String){
    sound_status = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
    if(sound_status==true){
        let url = Bundle.main.url(forResource: file_name, withExtension: nil)
        guard url != nil else{
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
