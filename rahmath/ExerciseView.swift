//  ExerciseView.swift
//  freedom
//
//  Created by Aang Muammar Zein on 31/03/23.
//

import AVKit
import SwiftUI

struct ExerciseView: View {
    @AppStorage("BADGE_1") var badge1: Int = 0
    @AppStorage("BADGE_2") var badge2: Int = 0
    @AppStorage("BADGE_3") var badge3: Int = 0
    @AppStorage("TOTAL_CORRECT") var totalCorrect: Int = 0
    @AppStorage("TOTAL_INCORRECT") var totalIncorrect: Int = 0
    @AppStorage("TOTAL_QUESTION") var totalQuestion: Int = 0
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    @State private var objects: [ModelObjectExercise] = [
        ModelObjectExercise(name: "apple", img: "object_apple"),
        ModelObjectExercise(name: "egg", img: "object_egg"),
        ModelObjectExercise(name: "pencil", img: "object_pencil"),
        ModelObjectExercise(name: "donut", img: "object_donut"),
        ModelObjectExercise(name: "peanut", img: "object_peanut"),
        ModelObjectExercise(name: "ball", img: "object_ball"),
        ModelObjectExercise(name: "avocado", img: "object_avocado"),
        ModelObjectExercise(name: "ice cream", img: "object_icecream"),
        ModelObjectExercise(name: "cake", img: "object_cake"),
        ModelObjectExercise(name: "eyeglasses", img: "object_eyeglasses")
    ]
    @State private var selectedObject = ModelObjectExercise()
    @State private var objectsQuestion1: [ModelObjectQuestionExercise] = []
    @State private var objectQuestion2: [ModelObjectQuestionExercise] = []
    @State private var optionsAnswer: [ModelAnswerQuestionExercise] = [
        ModelAnswerQuestionExercise(),
        ModelAnswerQuestionExercise(),
        ModelAnswerQuestionExercise(),
        ModelAnswerQuestionExercise()
    ]
    @State private var selectedAnswers: [ModelAnswerSelectedExercise] = []
    @State private var img = "rahmath_1"
    @State private var num1 = 0
    @State private var num2 = 0
    @State private var op = "+"
    @State private var operatorIcon = "plus.circle"
    @State private var result = 0
    @State private var index = 0
    @State private var questionLimit = 4
    @State private var checkAnswer = false
    @State private var questionNum = 0
    @State private var answerStatus = false
    @State private var optionSelected = 0
    @State private var correctAnswer = 0
    @State private var incorrectAnswer = 0

    @State private var isActive = false

    struct ModelObjectExercise: Identifiable {
        var id = UUID()
        var name: String = "nama object"
        var img: String = "object_default"
    }

    struct ModelObjectQuestionExercise: Identifiable {
        var id: Int = 0
        var x: Int = 0
        var y: Int = 0
        var location: CGPoint = .init(x: 0, y: 0)
        var isDragging = false
        var status = false
    }

    struct ModelAnswerQuestionExercise: Identifiable {
        var id: Int = 0
        var option: Int = 0
        var status = false
    }

    struct ModelAnswerSelectedExercise: Identifiable {
        var id: Int = 0
        var option: Int = 0
        var status = false
    }

    func answerCheck(option: Int) {
        checkAnswer = true
        optionSelected = option
        if result == option {
            getHapticsNotify(.success)
            playSound(audioName: "correct.mp3")
            correctAnswer += 1
            img = "rahmath_2"

            answerStatus = true
            selectedAnswers.append(ModelAnswerSelectedExercise(option: optionSelected, status: true))
        } else {
            getHapticsNotify(.warning)
            playSound(audioName: "incorrect.mp3")
            incorrectAnswer += 1
            img = "rahmath_3"
            answerStatus = false
            selectedAnswers.append(ModelAnswerSelectedExercise(option: optionSelected, status: false))
        }
        if questionNum == questionLimit {
            calculate_badge()
        }
        print("Answer Check : " + String(checkAnswer))
    }

    func calculate_badge() {
        if correctAnswer == 4 {
            badge1 += 1
        } else if correctAnswer == 3 {
            badge2 += 1
        } else if correctAnswer == 2 {
            badge3 += 1
        }
        totalCorrect += correctAnswer
        totalIncorrect += incorrectAnswer
        totalQuestion += questionNum
    }

    func reset() {
        index = 0
        result = 0
        img = "rahmath_1"
        checkAnswer = false
        objectsQuestion1.removeAll()
        objectQuestion2.removeAll()
    }

    func play() {
        getHapticsNotify(.success)

        questionNum += 1
        reset()
        print("Question : " + String(questionNum))
        print("Limit : " + String(questionLimit))
        print("Answer Check : " + String(checkAnswer))

        if CGFloat(questionNum) / CGFloat(questionLimit) <= 0.5 {
            op = "+"
            operatorIcon = "plus.circle"
            num1 = Int.random(in: 1 ..< 5)
            num2 = Int.random(in: 1 ..< 5)

            result = num1 + num2

        } else {
            op = "-"
            operatorIcon = "minus.circle"
            num1 = Int.random(in: 1 ..< 5)
            num2 = Int.random(in: 0 ..< num1)
            if num2 == 0 {
                num2 = 1
            }

            result = num1 - num2
        }

        var x = 40
        var y = 40
        for i in 0 ... (num1 - 1) {
            objectsQuestion1.append(
                ModelObjectQuestionExercise(
                    id: index,
                    x: x,
                    y: y,
                    location: CGPoint(x: x, y: y),
                    isDragging: false)
            )
            x += 60
            if i > 0, i % 2 != 0 {
                y += 60
                x = 40
            }
            index += 1
        }

        x = 40
        y = 40
        for i in 0 ... (num2 - 1) {
            objectQuestion2.append(
                ModelObjectQuestionExercise(
                    id: index,
                    x: x,
                    y: y,
                    location: CGPoint(x: x, y: y),
                    isDragging: false)
            )
            x += 60
            if i > 0, i % 2 != 0 {
                y += 60
                x = 40
            }
            index += 1
        }

        index = Int.random(in: 0 ..< 4)
        optionsAnswer[index] = ModelAnswerQuestionExercise(id: index, option: result)

        for i in 0 ... 3 where i != index {
                for _ in 0 ... 100 {
                    let option = Int.random(in: 1 ..< 9)
                    if option != optionsAnswer[0].option,
                       option != optionsAnswer[1].option,
                       option != optionsAnswer[2].option,
                       option != optionsAnswer[3].option {
                        optionsAnswer[i] = ModelAnswerQuestionExercise(id: i, option: option)
                        break
                    }
                }
        }
        index = Int.random(in: 0 ..< objects.count)
        selectedObject = objects[index]
    }

    @State var isPop: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        Text("Question #" + String(questionNum)
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
                                    (screenWidth - 40) * (CGFloat(questionNum) / CGFloat(questionLimit)),
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
                            ForEach(objectsQuestion1) { val in
                                Image(selectedObject.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50).shadow(radius: 4, x: 4, y: 4).position(val.location)
                            }

                            ZStack {
                                Circle()
                                    .foregroundColor(Color("colorWhite")
                                        .opacity(0.5))
                                    .frame(height: 40)
                                Text(String(num1))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite")).frame(height: 40)
                            }.offset(y: 50)
                        }
                        Image(systemName: operatorIcon)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("colorBlue"))
                            .frame(width: 50)
                        ZStack {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorBlue"))
                            ForEach(objectQuestion2) { val in
                                Image(selectedObject.img)
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
                                Text(String(num2))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite"))
                                    .frame(height: 40)
                            }.offset(y: 50)
                        }
                    }.padding(.bottom, 20)

                }.padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))

                VStack {
                    VStack {
                        Image(img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100).padding(.bottom, 20)

                        if checkAnswer == true, questionNum < questionLimit {
                            Button {
                                if questionNum < questionLimit {
                                    play()
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
                        } else if checkAnswer == true, questionNum >= questionLimit {

                            Button {
                                isActive = true
                            } label: {
                                Text("Check Your Result")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .navigationDestination(isPresented: $isActive) {
                                ResultView(correctAnswer: correctAnswer, numberOfQuestion: questionNum)
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
                    .frame(width: screenWidth, height: 200)
                    .background(Color("colorWhite"))
                    .cornerRadius(40).padding(.top, -30)

                    VStack(spacing: 30) {
                        if checkAnswer == false {
                            HStack(spacing: 30) {
                                ForEach(0 ..< 2) { index in
                                    Button {
                                            answerCheck(option: optionsAnswer[index].option)
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }
                                    }
                                }
                            }
                            HStack(spacing: 30) {
                                ForEach(2 ..< 4) { index in
                                    Button {
                                            answerCheck(option: optionsAnswer[index].option)
                                        }
                                label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }
                                    }
                                }
                            }
                        } else {
                            HStack(spacing: 30) {
                                ForEach(0 ..< 2) { index in
                                    if optionsAnswer[index].option == optionSelected {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 90)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    answerStatus == true ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorBlue"), lineWidth: 5))
                                                .padding(2)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorWhite"), lineWidth: 3))
                                            Text(String(optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(1)
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    optionsAnswer[index].option ==
                                                    result ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(optionsAnswer[index].option == result ? 1 : 0.4)
                                    }
                                }
                            }
                            HStack(spacing: 30) {
                                ForEach(2 ..< 4) { index in
                                    if optionsAnswer[index].option == optionSelected {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 90)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    answerStatus == true ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorBlue"), lineWidth: 5))
                                                .padding(2)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorWhite"), lineWidth: 3))
                                            Text(String(optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(1)
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(
                                                    optionsAnswer[index].option ==
                                                    result ? Color("colorGreen") : Color("colorWhite")
                                                )
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(optionsAnswer[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(optionsAnswer[index].option == result ? 1 : 0.4)
                                    }
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 150, trailing: 20))
                    .background(Color("colorBlue"))
                }
                .background(Color("colorBlue"))
                .frame(maxWidth: screenWidth)
            }.task {
                play()
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
