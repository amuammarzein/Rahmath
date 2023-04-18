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
//var file_name = "backsound_2.mp3"

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

var myQueuePlayer: AVQueuePlayer?

var avItems: [AVPlayerItem] = []


func playSoundMultiple(file_name: [String]){
    sound_status = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
    if(sound_status==true){
        
        avItems.removeAll()
        
        var items: [String] = file_name
        


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



