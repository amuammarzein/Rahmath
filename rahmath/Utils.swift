//
//  Utils.swift
//  Rahmath
//
//  Created by Aang Muammar Zein on 03/04/23.
//

import AVFoundation
import Foundation
import SwiftUI
import UIKit

var vibratorStatus = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
var vibratorIcon = UserDefaults.standard.string(forKey: "VIBRATOR_ICON")
var soundStatus = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
var soundIcon = UserDefaults.standard.string(forKey: "SOUND_ICON")
var musicStatus = UserDefaults.standard.bool(forKey: "MUSIC_STATUS")
var musicIcon = UserDefaults.standard.string(forKey: "MUSIC_ICON")

func getHaptics(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
    vibratorStatus = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
    if vibratorStatus == true {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
}

func getHapticsNotify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
    vibratorStatus = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
    if vibratorStatus == true {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}

func soundSetting() {
    getHapticsNotify(.success)
    soundStatus = UserDefaults.standard.bool(forKey: "SOUND_STATUS")
    soundIcon = UserDefaults.standard.string(forKey: "SOUND_ICON")
    if soundStatus == true {
        soundStatus = false
        soundIcon = "waveform.slash"
    } else {
        soundStatus = true
        soundIcon = "waveform"
    }
    UserDefaults.standard.set(soundStatus, forKey: "SOUND_STATUS")
    UserDefaults.standard.set(soundIcon, forKey: "SOUND_ICON")
}

func musicSetting() {
    getHapticsNotify(.success)
    musicStatus = UserDefaults.standard.bool(forKey: "MUSIC_STATUS")
    musicIcon = UserDefaults.standard.string(forKey: "MUSIC_ICON")

    if musicStatus == true {
        stopMusic()
        musicStatus = false
        musicIcon = "speaker.slash.fill"
    } else {
        playMusic()
        musicStatus = true
        musicIcon = "speaker.wave.2.fill"
    }
    UserDefaults.standard.set(musicStatus, forKey: "MUSIC_STATUS")
    UserDefaults.standard.set(musicIcon, forKey: "MUSIC_ICON")
}

func vibratorSetting() {
    getHapticsNotify(.success)
    vibratorStatus = UserDefaults.standard.bool(forKey: "VIBRATOR_STATUS")
    vibratorIcon = UserDefaults.standard.string(forKey: "VIBRATOR_ICON")
    if vibratorStatus == true {
        vibratorStatus = false
        vibratorIcon = "hand.raised.slash.fill"
    } else {
        vibratorStatus = true
        vibratorIcon = "hand.raised.fill"
    }
    UserDefaults.standard.set(vibratorStatus, forKey: "VIBRATOR_STATUS")
    UserDefaults.standard.set(vibratorIcon, forKey: "VIBRATOR_ICON")
}

struct SettingView: View {
    @AppStorage("SOUND_STATUS") var soundStatus: Bool = true
    @AppStorage("SOUND_ICON") var soundIcon: String = "waveform"
    @AppStorage("MUSIC_STATUS") var musicStatus: Bool = true
    @AppStorage("MUSIC_ICON") var musicIcon: String = "speaker.wave.2.fill"
    @AppStorage("VIBRATOR_STATUS") var vibratorStatus: Bool = true
    @AppStorage("VIBRATOR_ICON") var vibratorIcon: String = "hand.raised.fill"

    @Binding var isPop: Bool

    var body: some View {
        HStack {
            Button {
                    isPop.toggle()
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("colorBlue"))
                    Image(systemName: "gear")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30))
                }
            }
        }.popover(isPresented: $isPop) {
            VStack {
                Text("Game Settings").font(.system(size: 30, weight: .heavy, design: .rounded)).padding(.bottom, 20)
                HStack {
                    VStack {
                        Button {
                                vibratorSetting()
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("colorBlue"))
                                Image(systemName: vibratorIcon)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 40))
                            }
                        }
                        Text("Haptic").font(.system(size: 20, weight: .heavy, design: .rounded))
                    }

                    VStack {
                        Button {
                                soundSetting()
                        } label: {
                            ZStack {
                                Circle().frame(width: 60, height: 60).foregroundColor(Color("colorBlue"))
                                Image(systemName: soundIcon).foregroundColor(Color.white).font(.system(size: 40))
                            }
                        }
                        Text("Sound")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                    }
                    .padding(.leading, 30).padding(.trailing, 30)

                    VStack {
                        Button {
                                musicSetting()
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("colorBlue"))
                                Image(systemName: musicIcon)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 40))
                            }
                        }
                        Text("Music")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                    }
                }

                Button {
                        isPop.toggle()

                    } label: { Text("Close")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .padding()
                        .frame(maxWidth: .infinity)

                }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    .buttonBorderShape(.capsule)
                    .compositingGroup()
                    .shadow(color: Color("colorRedDark"), radius: 0, x: 1, y: 5)
                    .padding(.top, 20).padding(.leading, 20)
                    .padding(.trailing, 20).padding(.bottom, 50)

                VStack {
                    Text("Rahmath Team")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                        .padding(.bottom, 20)

                    Text("Aang, As'adi, Billbert, Ruci, Yaya")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .padding()
                        .frame(maxWidth: .infinity).padding(.top, -30)
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

func numberToMp3(number: Int) -> String {
    let arrNumberMp3 = ["one.mp3", "two.mp3", "three.mp3", "four.mp3", "five.mp3", "six.mp3", "seven.mp3", "eight.mp3"]
    return arrNumberMp3[number - 1]
}
