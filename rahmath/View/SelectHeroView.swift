//
//  SelectHeroView.swift
//  rahmathios
//
//  Created by Aang Muammar Zein on 30/03/23.
//

import SwiftUI

struct SelectHeroView: View {
    @ObservedObject var viewModel = SelectHeroViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Color(viewModel.heroColor).edgesIgnoringSafeArea(.all)
                    Image("heroSelected")
                        .resizable()
                        .scaledToFit()
                        .frame(width: viewModel.screenWidth / 1.8)
                    Image(viewModel.heroImg)
                        .resizable()
                        .scaledToFit()
                        .frame(width: viewModel.screenWidth / 2)
                        .shadow(color: .black, radius: 2, x: 3, y: 3)
                        .offset(x: 0, y: viewModel.movingIcon ? -5 : 0)
                        .animation(.spring(response: 1, dampingFraction: 0.0, blendDuration: 0.0)
                            .repeatForever(autoreverses: false), value: viewModel.movingIcon).task {
                                viewModel.movingIcon.toggle()
                        }
                    Image("heroSelected_badge")
                        .resizable().scaledToFit()
                        .frame(width: viewModel.screenWidth / 2)
                        .shadow(color: .black, radius: 2, x: 3, y: 3)

                }.onTapGesture {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                VStack(alignment: .leading) {
                    Color("colorWhite").edgesIgnoringSafeArea(.all)
                    Text("Choose your hero")
                        .foregroundColor(Color.black)
                        .font(Font.system(size: 20, design: .rounded)
                            .weight(.bold))
                        .padding(.leading, 20).padding(.top, 30).padding(.bottom, 0)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0 ..< viewModel.heroes.count, id: \.self) { index in
                                Button {
                                    viewModel.selectHero(index: index)
                                    getHapticsNotify(.success)
                                } label: {
                                    ZStack {
                                        if viewModel.heroId == viewModel.heroes[index].id {
                                            Circle()
                                                .fill(Color(viewModel.heroes[index].color))
                                                .frame(
                                                    width: viewModel.screenWidth / 3.5,
                                                    height: viewModel.screenWidth / 3.5
                                                )
                                            Circle()
                                                .fill(Color("colorWhite"))
                                                .frame(
                                                    width: viewModel.screenWidth / 3.7,
                                                    height: viewModel.screenWidth / 3.7
                                                )
                                        } else {
                                            Circle()
                                                .fill(Color("colorWhite"))
                                                .frame(
                                                    width: viewModel.screenWidth / 4.5,
                                                    height: viewModel.screenWidth / 4.5)
                                            Circle()
                                                .fill(Color("colorWhite"))
                                                .frame(
                                                    width: viewModel.screenWidth / 4.7,
                                                    height: viewModel.screenWidth / 4.7
                                                )
                                        }

                                        Circle()
                                            .fill(Color(viewModel.heroes[index].color))
                                            .opacity(0.25)
                                            .frame(width: viewModel.screenWidth / 4, height: viewModel.screenWidth / 4)
                                        Image(viewModel.heroes[index].img)
                                            .resizable()
                                            .scaledToFit().frame(width: viewModel.screenWidth / 6)
                                            .shadow(color: .black, radius: 2, x: 3, y: 3)
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
                        TextField("Write your name", text: $viewModel.heroName)
                            .padding(.leading, 10)
                            .frame(height: 60)
                            .font(Font.system(size: 18, design: .rounded)
                                .weight(.bold))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("colorRed"), lineWidth: 3))
                            .padding(.trailing, 5).padding(.top, 4)

                        Button {
                            viewModel.isActive = true
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
                        .navigationDestination(isPresented: $viewModel.isActive) {
                            HomeView().navigationBarBackButtonHidden(true)
                        }

                    }.padding(EdgeInsets(top: 10, leading: 20, bottom: 50, trailing: 20))

                }
                .background(Color("colorWhite"))
                    .cornerRadius(50)
                    .padding(.top, -50)
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
