//
//  TutorialView.swift
//  freedom
//
//  Created by Aang Muammar Zein on 31/03/23.
//

import AVFoundation
import SwiftUI

struct TutorialView: View {
    @ObservedObject var viewModel = TutorialViewModel()

    @State var isPop: Bool = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ZStack {
                    Image("basket_2")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                .zIndex(3)
                .padding(.bottom, 200)
                ZStack {
                    Circle()
                        .foregroundColor(Color("colorBlue").opacity(0.9))
                        .frame(height: 40)
                        .padding(.top, 70)
                    Text(String(viewModel.totalObjectInBasket))
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(Color("colorWhite"))
                        .frame(height: 60)
                        .padding(.top, 70)
                }
                .zIndex(5)
                .padding(.bottom, 200)
                ZStack(alignment: .bottom) {
                    VStack {
                        Spacer()
                        Text(viewModel.text)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .padding(.bottom, 30)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                            .onTapGesture {
                                viewModel.playSays()
                        }
                        if viewModel.checkTutorial == true, viewModel.numQuestion < viewModel.limitQuestion {
                            Button {
                                if viewModel.numQuestion < viewModel.limitQuestion {
                                    viewModel.play()

                                }
                            } label: {
                                Text("Next Tutorial")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .padding()
                                    .frame(maxWidth: .infinity)

                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                            .buttonBorderShape(.capsule)
                            .compositingGroup()
                            .shadow(color: Color("colorRedDark"), radius: 0, x: 1, y: 5)
                            .padding(.bottom, 20).padding(.leading, 20).padding(.trailing, 20)
                        } else if viewModel.checkTutorial == true, viewModel.numQuestion >= viewModel.limitQuestion {
                            Button {
                                viewModel.isActive = true
                            } label: {
                                Text("Back to Home")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .navigationDestination(isPresented: $viewModel.isActive) {
                                HomeView().navigationBarBackButtonHidden(true)
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                            .buttonBorderShape(.capsule)
                            .compositingGroup()
                            .shadow(color: Color("colorRedDark"), radius: 0, x: 1, y: 5)
                            .padding(.bottom, 20).padding(.leading, 20).padding(.trailing, 20)
                        }
                    }
                }
                .zIndex(4)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 130)

                ZStack {
                    HStack(alignment: .top) {
                        ZStack(alignment: .top) {
                            ForEach(viewModel.objectQuestion1) { val in
                                Image(viewModel.objectSelected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: val.isDragging == true ? 75 : 50)
                                    .shadow(radius: 4, x: 4, y: 4)
                                    .position(val.location)
                                    .gesture(viewModel.dragElement(index: val.id, que: 1))
                            }

                        }.zIndex(1)
                        Image(systemName: viewModel.operatorIcon)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("colorWhite"))
                            .padding(.top, 40).frame(width: 50)
                            .opacity(0)
                        ZStack(alignment: .top) {
                            ForEach(viewModel.objectQuestion2) { val in
                                Image(viewModel.objectSelected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: val.isDragging == true ? 75 : 50)
                                    .shadow(radius: 4, x: 4, y: 4)
                                    .position(val.location)
                                    .gesture(viewModel.dragElement(index: val.id - viewModel.num1, que: 2))
                            }
                        }
                        .zIndex(1)
                    }
                }
                .zIndex(6)
                    .padding(.leading, 20).padding(.trailing, 20).padding(.top, 130)

                ZStack {
                    if viewModel.checkTutorial == true {
                        ExplodingView()
                    }
                    HStack(alignment: .top) {
                        ZStack(alignment: .top) {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorWhite")
                                    .opacity(0.3))
                            ForEach(viewModel.objectQuestion1) { val in
                                Image(viewModel.objectSelected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .position(val.location)
                                    .opacity(0)
                            }
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("colorBlue").opacity(0.9))
                                    .frame(height: 40)
                                Text(String(viewModel.num1))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite"))
                                    .frame(height: 40)
                            }.offset(y: 50)
                        }
                        Image(systemName: viewModel.operatorIcon)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("colorWhite"))
                            .padding(.top, 40).frame(width: 50)
                        ZStack(alignment: .top) {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorWhite")
                                    .opacity(0.3))
                            ForEach(viewModel.objectQuestion2) { val in
                                Image(viewModel.objectSelected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .position(val.location)
                                    .opacity(0)
                            }
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("colorBlue")
                                        .opacity(0.9))
                                    .frame(height: 40)
                                Text(String(viewModel.num2))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite"))
                                    .frame(height: 40)
                            }.offset(y: 50)
                        }
                    }
                }
                .zIndex(5)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 130)

                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        Text("Tutorial #" + String(viewModel.numQuestion)
                        ).font(.system(size: 25, weight: .bold, design: .rounded))

                        Spacer()

                        SettingView(isPop: $isPop)
                    }
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 24)
                            .cornerRadius(20)
                            .padding(.bottom, 10)
                            .foregroundColor(Color("colorGrey"))
                            .opacity(0.5)
                        Rectangle()
                            .frame(width:
                                    (viewModel.screenWidth - 40) *
                                   (CGFloat(viewModel.numQuestion) / CGFloat(viewModel.limitQuestion)), height: 24)
                            .cornerRadius(20)
                            .padding(.bottom, 10)
                            .foregroundColor(Color("colorGreen"))
                    }
                    Spacer()

                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("colorBlue"))
                    .zIndex(1)

                Rectangle()
                    .foregroundColor(Color("colorWhite"))
                    .cornerRadius(40)
                    .frame(height: viewModel.screenHeight - 350)
                    .padding(.bottom, -50)
                    .zIndex(2)

            }.onAppear {
                viewModel.play()
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
