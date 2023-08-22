//
//  HomeView.swift
//  rahmathios
//
//  Created by Aang Muammar Zein on 30/03/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("SOUND_STATUS") var soundStatus: Bool = true
    @AppStorage("SOUND_ICON") var soundIcon: String = "waveform"
    @AppStorage("MUSIC_STATUS") var musicStatus: Bool = true
    @AppStorage("MUSIC_ICON") var musicIcon: String = "speaker.wave.2.fill"
    @AppStorage("VIBRATOR_STATUS") var vibratorStatus: Bool = true
    @AppStorage("VIBRATOR_ICON") var vibratorIcon: String = "hand.raised.fill"

    @AppStorage("HERO_IMG") var heroImg: String = "avatar_2"
    @AppStorage("HERO_ID") var heroId: String = "1"
    @AppStorage("HERO_NAME") var heroName: String = "Rahmath"
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height

    @AppStorage("BADGE_1") var badge1: Int = 0
    @AppStorage("BADGE_2") var badge2: Int = 0
    @AppStorage("BADGE_3") var badge3: Int = 0
    @AppStorage("TOTAL_CORRECT") var totalCorrect: Int = 0
    @AppStorage("TOTAL_INCORRECT") var totalIncorrect: Int = 0
    @AppStorage("TOTAL_QUESTION") var totalQuestion: Int = 0

    @State private var isActive = false

    @State var isPop: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        NavigationLink(destination: SelectHeroView().navigationBarBackButtonHidden(true)) {
                            ZStack {
                                Circle()
                                    .frame(height: 60)
                                    .foregroundColor(Color("colorWhite"))
                                    .shadow(radius: 2, x: 3, y: 3)
                                Image(heroImg)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .shadow(radius: 2, x: 3, y: 3)
                            }.padding(.trailing, 10)
                            VStack(alignment: .leading) {
                                Text("Hello, ")
                                    .font(.system(size: 20, weight: .light, design: .rounded))
                                    .foregroundColor(Color("colorBlack"))
                                Text(heroName + "!")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("colorBlack")).lineLimit(1)
                            }
                        }
                        Spacer()
                        SettingView(isPop: $isPop)

                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 50, trailing: 20))

                    VStack {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("My Badges")
                                .font(.system(size: 28, weight: .medium, design: .rounded))
                                .foregroundColor(Color("colorBlack"))
                            HStack {
                                VStack(spacing: 20) {
                                    VStack(spacing: 20) {
                                        ZStack {
                                            Circle()
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(radius: 2, x: 3, y: 3)
                                            Image("crown")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 40)
                                                .shadow(radius: 2, x: 3, y: 3)
                                        }
                                        HStack {
                                            Text(String(badge1))
                                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                                .foregroundColor(Color("colorWhite"))
                                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        }.frame(maxWidth: .infinity).background(Color("colorBlue")).cornerRadius(45)

                                    }.padding(15)

                                }.frame(maxWidth: .infinity)
                                    .background(Color("colorBlue")
                                        .opacity(0.5)).cornerRadius(45)

                                VStack(spacing: 20) {
                                    VStack(spacing: 20) {
                                        ZStack {
                                            Circle()
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(radius: 2, x: 3, y: 3)
                                            Image("diamond")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 40)
                                                .shadow(radius: 2, x: 3, y: 3)
                                        }
                                        HStack {
                                            Text(String(badge2))
                                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                                .foregroundColor(Color("colorWhite"))
                                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        }.frame(maxWidth: .infinity)
                                            .background(Color("colorBlue"))
                                            .cornerRadius(45)

                                    }.padding(15)

                                }
                                .frame(maxWidth: .infinity)
                                    .background(Color("colorBlue") .opacity(0.5))
                                    .cornerRadius(45)

                                VStack(spacing: 20) {
                                    VStack(spacing: 20) {
                                        ZStack {
                                            Circle()
                                                .frame(maxWidth: .infinity)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(radius: 2, x: 3, y: 3)
                                            Image("donut")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 40)
                                                .shadow(radius: 2, x: 3, y: 3)
                                        }
                                        HStack {
                                            Text(String(badge3))
                                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                                .foregroundColor(Color("colorWhite"))
                                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        }
                                        .frame(maxWidth: .infinity)
                                        .background(Color("colorBlue"))
                                        .cornerRadius(45)

                                    }.padding(15)

                                }
                                .frame(maxWidth: .infinity)
                                .background(Color("colorBlue").opacity(0.5))
                                .cornerRadius(45)
                            }
                        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("colorWhite"))
                    .cornerRadius(15)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)

                    Button {

                        isActive = true
                    } label: {
                        Text("Play")
                            .foregroundColor(Color("colorGreen"))
                            .padding(3)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .padding(8)
                            .frame(maxWidth: .infinity)
                    }
                    .navigationDestination(isPresented: $isActive) {
                        ExerciseView().navigationBarBackButtonHidden(true)
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    .buttonBorderShape(.capsule)
                    .compositingGroup()
                    .shadow(color: Color("colorRedDark"), radius: 0, x: 1, y: 5)
                    .padding(.top, 60).padding(.leading, 20).padding(.trailing, 20)

                    Text("Learn the tutorial down here!")
                        .foregroundColor(Color("colorWhite"))
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .padding(.top, 40).padding(.leading, 20).padding(.trailing, 20)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)

                    NavigationLink(destination: TutorialView().navigationBarBackButtonHidden(true)) {
                        Text("Tutorial")
                            .padding(3)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .padding(8)
                            .frame(maxWidth: .infinity)

                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity)
                    .buttonBorderShape(.capsule)
                    .compositingGroup()
                    .shadow(color: Color("colorRedDark"), radius: 0, x: 1, y: 5)
                    .padding(.top, 10).padding(.leading, 20).padding(.trailing, 20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("colorBlue"))
        }.task {
            getHapticsNotify(.success)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
