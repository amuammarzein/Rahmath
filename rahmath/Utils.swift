//
//  Audio.swift
//  Rahmath
//
//  Created by Aang Muammar Zein on 03/04/23.
//

import SwiftUI
import Foundation
import AVFoundation
import UIKit

var vibrator_status = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
var vibrator_icon = UserDefaults.standard.string(forKey: "VIBRATOR_ICON")
var sound_status = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
var sound_icon = UserDefaults.standard.string(forKey: "SOUND_ICON")
var music_status = UserDefaults.standard.bool(forKey: "MUSIC_STATUS")
var music_icon = UserDefaults.standard.string(forKey: "MUSIC_ICON")



func getHaptics(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
    vibrator_status = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
    if(vibrator_status==true){
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
        
    }
}

func getHapticsNotify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
    vibrator_status = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
    if(vibrator_status==true){
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}

func soundSetting(){
    getHapticsNotify(.success)
    sound_status = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
    sound_icon = UserDefaults.standard.string(forKey: "SOUND_ICON")
    if(sound_status == true){
        sound_status = false
        sound_icon = "waveform.slash"
    }else{
        sound_status = true
        sound_icon = "waveform"
    }
    UserDefaults.standard.set(sound_status, forKey: "SOUND_STATUS")
    UserDefaults.standard.set(sound_icon, forKey: "SOUND_ICON")
}

func musicSetting(){
    
    getHapticsNotify(.success)
    music_status = UserDefaults.standard.bool(forKey: "MUSIC_STATUS")
    music_icon = UserDefaults.standard.string(forKey: "MUSIC_ICON")
    
    if(music_status == true){
        stopMusic()
        music_status = false
        music_icon = "speaker.slash.fill"
    }else{
        playMusic()
        music_status = true
        music_icon = "speaker.wave.2.fill"
    }
    UserDefaults.standard.set(music_status, forKey: "MUSIC_STATUS")
    UserDefaults.standard.set(music_icon, forKey: "MUSIC_ICON")
    
}


func vibratorSetting(){
    getHapticsNotify(.success)
    vibrator_status = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
    vibrator_icon = UserDefaults.standard.string(forKey: "VIBRATOR_ICON")
    if(vibrator_status == true){
        vibrator_status = false
        vibrator_icon = "hand.raised.slash.fill"
    }else{
        vibrator_status = true
        vibrator_icon = "hand.raised.fill"
    }
    UserDefaults.standard.set(vibrator_status, forKey: "VIBRATOR_STATUS")
    UserDefaults.standard.set(vibrator_icon, forKey: "VIBRATOR_ICON")
}




struct SettingView: View{
    
    @AppStorage("SOUND_STATUS") var sound_status: Bool = true
    @AppStorage("SOUND_ICON") var sound_icon:String = "waveform"
    @AppStorage("MUSIC_STATUS") var music_status: Bool = true
    @AppStorage("MUSIC_ICON") var music_icon:String = "speaker.wave.2.fill"
    @AppStorage("VIBRATOR_STATUS") var vibrator_status: Bool = true
    @AppStorage("VIBRATOR_ICON") var vibrator_icon:String = "hand.raised.fill"
    
    @Binding var isPop:Bool
    
    var body: some View {
        HStack(){
            Button(
                action:{
                    isPop.toggle()
                }
            ){
                ZStack(){
                    Circle().frame(width:50,height:50).foregroundColor(Color("colorBlue"))
                    Image(systemName: "gear").foregroundColor(Color.white).font(.system(size:30))
                }
            }
        }.popover(isPresented: $isPop) {
            VStack(){
                Text("Game Settings").font(.system(size:30,weight: .heavy,design:.rounded)).padding(.bottom,20)
                HStack(){
                    VStack(){
                        Button(
                            action:{
                                vibratorSetting()
                            }
                        ){
                            ZStack(){
                                Circle().frame(width:60,height:60).foregroundColor(Color("colorBlue"))
                                Image(systemName: vibrator_icon).foregroundColor(Color.white).font(.system(size:40))
                            }
                        }
                        Text("Haptic").font(.system(size:20,weight: .heavy,design:.rounded))
                    }
                    
                    VStack(){
                        Button(
                            action:{
                                soundSetting()
                            }
                        ){
                            ZStack(){
                                Circle().frame(width:60,height:60).foregroundColor(Color("colorBlue"))
                                Image(systemName: sound_icon).foregroundColor(Color.white).font(.system(size:40))
                            }
                        }
                        Text("Sound").font(.system(size:20,weight: .heavy,design:.rounded))
                    }.padding(.leading,30).padding(.trailing,30)
                    
                    VStack(){
                        Button(
                            action:{
                                musicSetting()
                            }
                        ){
                            ZStack(){
                                Circle().frame(width:60,height:60).foregroundColor(Color("colorBlue"))
                                Image(systemName: music_icon).foregroundColor(Color.white).font(.system(size:40))
                            }
                            
                        }
                        Text("Music").font(.system(size:20,weight: .heavy,design:.rounded))
                    }
                }
                
                Button(
                    action:{
                        isPop.toggle()
                        
                    }
                ){
                    Text("Close")
                        .font(.system(size: 20,weight:.regular ,design: .rounded)).padding().frame(maxWidth: .infinity)
                    
                }.buttonStyle(.borderedProminent).frame(maxWidth:.infinity)
                    .buttonBorderShape(.capsule).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5).padding(.top,20).padding(.leading,20).padding(.trailing,20).padding(.bottom,50)
                
                VStack(){
                Text("Rahmath Team").font(.system(size:30,weight: .heavy,design:.rounded)).padding(.bottom,20)
              
                    Text("Aang, As'adi, Billbert, Ruci, Yaya").font(.system(size: 20,weight:.regular ,design: .rounded)).padding().frame(maxWidth: .infinity).padding(.top,-30)
                }
        
                
            }
            .frame(maxWidth: .infinity)
        }
        
    }
}

func numberToMp3(number:Int)->String{
    var arrNumberMp3 = ["one.mp3","two.mp3","three.mp3","four.mp3","five.mp3","six.mp3","seven.mp3","eight.mp3"]
    return arrNumberMp3[number-1]
}


