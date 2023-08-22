//  ExerciseView.swift
//  freedom
//
//  Created by Aang Muammar Zein on 31/03/23.
//

import AVKit
import SwiftUI

struct ExerciseView: View {
    @ObservedObject var viewModel = ExerciseViewModel()
    @State var isPop: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        Text("Question #" + String(viewModel.questionNum)
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
                            .opacity(0.3)
                        Rectangle()
                            .frame(width:
                                    (
                                        viewModel.screenWidth - 40) * (CGFloat(viewModel.questionNum) / CGFloat(
                                            viewModel.questionLimit
                                        )
                                        ),
                                   height: 24)
                            .cornerRadius(20)
                            .padding(.bottom, 10)
                            .foregroundColor(Color("colorGreen"))
                    }
                    HStack {
                        ZStack {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorBlue"))
                            ForEach(viewModel.objectsQuestion1) { val in
                                Image(viewModel.selectedObject.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50).shadow(radius: 4, x: 4, y: 4).position(val.location)
                            }

                            ZStack {
                                Circle()
                                    .foregroundColor(Color("colorWhite")
                                        .opacity(0.5))
                                    .frame(height: 40)
                                Text(String(viewModel.num1))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite")).frame(height: 40)
                            }.offset(y: 50)
                        }
                        Image(systemName: viewModel.operatorIcon)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("colorBlue"))
                            .frame(width: 50)
                        ZStack {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorBlue"))
                            ForEach(viewModel.objectQuestion2) { val in
                                Image(viewModel.selectedObject.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .shadow(radius: 4, x: 4, y: 4).position(val.location)
                            }
                            ZStack {
                                Circle()
                                    .foregroundColor(Color("colorWhite")
                                        .opacity(0.5))
                                    .frame(height: 40)
                                Text(String(viewModel.num2))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite"))
                                    .frame(height: 40)
                            }.offset(y: 50)
                        }
                    }.padding(.bottom, 20)

                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))

                VStack {
                    VStack {
                        Image(viewModel.img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100).padding(.bottom, 20)

                        if viewModel.checkAnswer == true, viewModel.questionNum < viewModel.questionLimit {
                            Button {
                                if viewModel.questionNum < viewModel.questionLimit {
                                    viewModel.play()
                                }
                            } label: {
                                Text("Next Question")
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
                        } else if viewModel.checkAnswer == true, viewModel.questionNum >= viewModel.questionLimit {

                            Button {
                                viewModel.isActive = true
                            } label: {
                                Text("Check Your Result")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .navigationDestination(isPresented: $viewModel.isActive) {
                                ResultView(
                                    correctAnswer: viewModel.correctAnswer,
                                    numberOfQuestion: viewModel.questionNum
                                )
                                    .navigationBarBackButtonHidden(true)
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                            .buttonBorderShape(.capsule)
                            .compositingGroup()
                            .shadow(color: Color("colorRedDark"), radius: 0, x: 1, y: 5)
                            .padding(.bottom, 20).padding(.leading, 20).padding(.trailing, 20)
                        }
                    }
                    .frame(width: viewModel.screenWidth, height: 200)
                    .background(Color("colorWhite"))
                    .cornerRadius(40).padding(.top, -30)

                    VStack(spacing: 30) {
                        if viewModel.checkAnswer == false {
                            HStack(spacing: 30) {
                                ForEach(0 ..< 2) { index in
                                    Button {
                                        viewModel.answerCheck(option: viewModel.optionsAnswer[index].option)
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(viewModel.optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }
                                    }
                                }
                            }
                            HStack(spacing: 30) {
                                ForEach(2 ..< 4) { index in
                                    Button {
                                        viewModel.answerCheck(option: viewModel.optionsAnswer[index].option)
                                        }
                                label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(viewModel.optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }
                                    }
                                }
                            }
                        } else {
                            HStack(spacing: 30) {
                                ForEach(0 ..< 2) { index in
                                    if viewModel.optionsAnswer[index].option == viewModel.optionSelected {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 90)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    viewModel.answerStatus ==
                                                    true ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorBlue"), lineWidth: 5))
                                                .padding(2)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorWhite"), lineWidth: 3))
                                            Text(String(viewModel.optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(1)
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    viewModel.optionsAnswer[index].option ==
                                                    viewModel.result ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(viewModel.optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(viewModel.optionsAnswer[index].option == viewModel.result ? 1 : 0.4)
                                    }
                                }
                            }
                            HStack(spacing: 30) {
                                ForEach(2 ..< 4) { index in
                                    if viewModel.optionsAnswer[index].option == viewModel.optionSelected {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 90)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    viewModel.answerStatus ==
                                                    true ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorBlue"), lineWidth: 5))
                                                .padding(2)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorWhite"), lineWidth: 3))
                                            Text(String(viewModel.optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(1)
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    viewModel.optionsAnswer[index].option ==
                                                    viewModel.result ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(viewModel.optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(viewModel.optionsAnswer[index].option == viewModel.result ? 1 : 0.4)
                                    }
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 150, trailing: 20))
                    .background(Color("colorBlue"))
                }
                .background(Color("colorBlue"))
                .frame(maxWidth: viewModel.screenWidth)
            }.task {
                viewModel.play()
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
