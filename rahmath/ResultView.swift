//
//  ResultView.swift
//  rahmath
//
//  Created by Aang Muammar Zein on 01/04/23.
//

import AVFoundation
import SwiftUI

struct ResultView: View {
    var correctAnswer: Int
    var numberOfQuestion: Int
    @State private var emoji = "sad"
    @State private var statusText = "Congrats!"
    @State private var statusBadgeText = "You earn new badge!"
    @State private var gainMoreText = "One step closer to be the king of Math, Gain more badge to be great!"
    @State private var isActive = false
    @State var animate: Bool = false
    let animation: Animation = .linear(duration: 5).repeatForever(autoreverses: false)
    @State var movingIcon: Bool = false
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    func play() {
        if correctAnswer > 1 {
            playSound(audioName: "complete.mp3")

        } else {
            playSound(audioName: "incomplete.mp3")
        }
        if correctAnswer == 4 {
            emoji = "crown"

        } else if correctAnswer == 3 {
            emoji = "diamond"

        } else if correctAnswer == 2 {
            emoji = "donut"

        } else {
            statusText = "Fail!"
            statusBadgeText = "You don't earn new badge!"
            gainMoreText = "One step closer to be the king of Math, Gain more badge to be great!"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                Color("colorBlue")
                VStack(spacing: 10) {
                    Text(statusText).font(.system(size: 48, weight: .heavy, design: .rounded))
                    ZStack {
                        ExplodingView().zIndex(10)
                        Circle().foregroundColor(Color("colorGreen")).frame(width: 250).blur(radius: 50)
                        Image(emoji)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .shadow(color: .black, radius: 2, x: 3, y: 3)
                            .offset(x: 0, y: movingIcon ? -5 : 0)
                            .animation(.spring(response: 1, dampingFraction: 0.0, blendDuration: 0.0).repeatForever(autoreverses: false), value: movingIcon).task {
                                movingIcon.toggle()
                            }
                        Image("hero_selected_badge")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 280)
                            .shadow(color: .black, radius: 2, x: 3, y: 3)
                    }
                    HStack {
                        ZStack {
                            Circle()
                                .frame(height: 50).foregroundColor(Color("colorGreen"))
                            Text(String(correctAnswer))
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                        }
                        Text("Answer Correct!").font(.system(size: 20, weight: .regular, design: .rounded))
                    }
                    Text(statusBadgeText)
                        .font(.system(size: 24, weight: .bold, design: .rounded)).multilineTextAlignment(.center)
                    Text(statusBadgeText)
                        .font(.system(size: 18, weight: .light, design: .rounded))
                        .multilineTextAlignment(.center)

                    Button {
                        isActive = true

                    } label: {
                        Text("Play again!")
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
                    .padding(.top, 20)

                    NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                        Text("I'll come back later")
                            .font(.system(size: 18, weight: .light, design: .rounded))
                            .foregroundColor(Color("colorBlack")).padding(.top, 10)
                    }

                }.frame(maxWidth: screenWidth)
                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
                    .background(Color("colorWhite"))
                    .cornerRadius(40)
            }.padding(.leading, 20)
                .padding(.trailing, 20)
                .background(Color("colorBlue")).onAppear {
                play()
            }
        }.task {
            getHapticsNotify(.success)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(correctAnswer: 3, numberOfQuestion: 4)
    }
}
