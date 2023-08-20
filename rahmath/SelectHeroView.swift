//
//  SelectHeroView.swift
//  rahmathios
//
//  Created by Aang Muammar Zein on 30/03/23.
//

import SwiftUI

struct SelectHeroView: View {
    @AppStorage("HERO_COLOR") var heroColor: String = "colorGreen"
    @AppStorage("HERO_IMG") var heroImg: String = "avatar_2"
    @AppStorage("HERO_ID") var heroId: String = "1"
    @AppStorage("HERO_NAME") var heroName: String = "Rahmath"

    @State var animate: Bool = false
    let animation: Animation = .linear(duration: 5).repeatForever(autoreverses: false)
    @State var movingIcon: Bool = false

    @State private var heroes: [HeroModel] = [
        HeroModel(id: "1", name: "Octopus", img: "avatar_2", color: "colorGreen"),
        HeroModel(id: "2", name: "Octopus", img: "avatar_1", color: "colorRed"),
        HeroModel(id: "3", name: "Octopus", img: "avatar_5", color: "colorBlue"),
        HeroModel(id: "4", name: "Octopus", img: "avatar_4", color: "colorGrey"),
        HeroModel(id: "5", name: "Octopus", img: "avatar_5", color: "colorGreen"),
        HeroModel(id: "6", name: "Octopus", img: "avatar_8", color: "colorRed"),
        HeroModel(id: "7", name: "Octopus", img: "avatar_7", color: "colorBlue"),
        HeroModel(id: "8", name: "Octopus", img: "avatar_6", color: "colorGrey")
    ]
    @State private var heroSelected = HeroModel(id: "1", name: "Octopus", img: "avatar_2", color: "colorGreen")
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    @State private var name = ""

    @State private var isActive = false

    struct HeroModel: Identifiable {
        var id: String = UUID().uuidString
        var name: String = ""
        var img: String = "avatar_default"
        var color: String = "colorBlue"
        var status = false
    }

    func selectHero(index: Int) {
        heroSelected = heroes[index]
        heroColor = heroSelected.color
        heroImg = heroSelected.img
        heroId = heroSelected.id
        print(heroSelected)
    }

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color(heroColor).edgesIgnoringSafeArea(.all)
                    Image("heroSelected")
                        .resizable().scaledToFit().frame(width: screenWidth / 1.8)
                    Image(heroImg)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth / 2)
                        .shadow(color: .black, radius: 2, x: 3, y: 3)
                        .offset(x: 0, y: movingIcon ? -5 : 0)
                        .animation(.spring(response: 1, dampingFraction: 0.0, blendDuration: 0.0)
                            .repeatForever(autoreverses: false), value: movingIcon).task {
                            movingIcon.toggle()
                        }
                    Image("heroSelected_badge")
                        .resizable().scaledToFit().frame(width: screenWidth / 2)
                        .shadow(color: .black, radius: 2, x: 3, y: 3)

                }.onTapGesture {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                VStack(alignment: .leading) {
                    Color("colorWhite").edgesIgnoringSafeArea(.all)
                    Text("Choose your hero").foregroundColor(Color.black)
                        .font(Font.system(size: 20, design: .rounded).weight(.bold)).padding(.leading, 20).padding(.top, 30).padding(.bottom, 0)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0 ..< heroes.count, id: \.self) { index in
                                Button {
                                    selectHero(index: index)
                                    getHapticsNotify(.success)
                                } label: {
                                    ZStack {
                                        if heroId == heroes[index].id {
                                            Circle().fill(Color(heroes[index].color)).frame(width: screenWidth / 3.5, height: screenWidth / 3.5)
                                            Circle().fill(Color("colorWhite")).frame(width: screenWidth / 3.7, height: screenWidth / 3.7)
                                        } else {
                                            Circle().fill(Color("colorWhite")).frame(width: screenWidth / 4.5, height: screenWidth / 4.5)
                                            Circle().fill(Color("colorWhite")).frame(width: screenWidth / 4.7, height: screenWidth / 4.7)
                                        }

                                        Circle()
                                            .fill(Color(heroes[index].color)).opacity(0.25).frame(width: screenWidth / 4, height: screenWidth / 4)
                                        Image(heroes[index].img)
                                            .resizable().scaledToFit().frame(width: screenWidth / 6).shadow(color: .black, radius: 2, x: 3, y: 3)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 20).padding(.top, 10)
                    }

                    Text("Write your name")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 20, design: .rounded).weight(.bold))
                        .padding(.leading, 20).padding(.top, 20)
                    HStack {
                        TextField("Write your name", text: $heroName)
                            .padding(.leading, 10)
                            .frame(height: 60)
                            .font(Font.system(size: 18, design: .rounded).weight(.bold))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color("colorRed"), lineWidth: 3))
                            .padding(.trailing, 5).padding(.top, 4)

                        Button {
                            isActive = true
                        } label: {
                            Image(systemName: "play.fill")
                                .fontWeight(.bold).frame(width: 50)
                                .font(Font.system(size: 25, design: .rounded).weight(.bold))
                                .foregroundColor(Color("colorGreen"))
                                .padding()
                                .background(Color("colorRed"))
                                .cornerRadius(15)
                                .compositingGroup()
                                .shadow(color: Color("colorRedDark"), radius: 0, x: 1, y: 5)
                        }
                        .navigationDestination(isPresented: $isActive) {
                            HomeView().navigationBarBackButtonHidden(true)
                        }

                    }.padding(EdgeInsets(top: 10, leading: 20, bottom: 50, trailing: 20))

                }.background(Color("colorWhite")).cornerRadius(50).padding(.top, -50)
            }

        }.task {
            getHapticsNotify(.success)
        }
    }
}

struct SelectHeroView_Previews: PreviewProvider {
    static var previews: some View {
        SelectHeroView()
    }
}
