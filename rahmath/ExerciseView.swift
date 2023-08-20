//  ExerciseView.swift
//  freedom
//
//  Created by Aang Muammar Zein on 31/03/23.
//

import AVKit
import SwiftUI

struct ExerciseView: View {
    @AppStorage("BADGE_1") var badge1: Int = 0
    @AppStorage("BADGE_2") var badge_2: Int = 0
    @AppStorage("BADGE_3") var badge_3: Int = 0
    @AppStorage("TOTAL_CORRECT") var total_correct: Int = 0
    @AppStorage("TOTAL_INCORRECT") var total_incorrect: Int = 0
    @AppStorage("TOTAL_QUESTION") var total_question: Int = 0
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    @State private var arr_object: [modelObject] = [
        //        modelObject(name:"motor",img: "element_motor"),
        //        modelObject(name:"apel",img: "element_apple"),
        //        modelObject(name:"pisang",img: "element_banana"),
        //        modelObject(name:"jeruk",img: "element_orange"),
        //        modelObject(name:"strawberry",img: "element_strawberry"),
        //        modelObject(name:"balon",img: "element_balloon"),
        //        modelObject(name:"ikan",img: "element_fish"),
        //        modelObject(name:"mobil",img: "element_racing_car"),
        //        modelObject(name:"bunga",img: "element_rose"),
        //        modelObject(name:"bunga",img: "element_sunflower"),
        //        modelObject(name:"bola",img: "element_ball"),
        modelObject(name: "apple", img: "object_apple"),
        modelObject(name: "egg", img: "object_egg"),
        modelObject(name: "pencil", img: "object_pencil"),
        modelObject(name: "donut", img: "object_donut"),
        modelObject(name: "peanut", img: "object_peanut"),
        modelObject(name: "ball", img: "object_ball"),
        modelObject(name: "avocado", img: "object_avocado"),
        modelObject(name: "ice cream", img: "object_icecream"),
        modelObject(name: "cake", img: "object_cake"),
        modelObject(name: "eyeglasses", img: "object_eyeglasses")
    ]
    @State private var object_selected = modelObject()
    @State private var arr_object_question_1: [modelObjectQuestion] = []
    @State private var arr_object_question_2: [modelObjectQuestion] = []
    @State private var arr_answer_option: [modelAnswerOption] = [
        modelAnswerOption(),
        modelAnswerOption(),
        modelAnswerOption(),
        modelAnswerOption()
    ]
    @State private var arr_answer_selected: [modelAnswerSelected] = []
    @State private var img = "rahmath_1"
    @State private var num_1 = 0
    @State private var num_2 = 0
    @State private var op = "+"
    @State private var op_icon = "plus.circle"
    @State private var result = 0
    @State private var index = 0
    @State private var limit_question = 4
    @State private var check_answer = false
    @State private var num_question = 0
    @State private var answer_status = false
    @State private var option_selected = 0
    @State private var correct_answer = 0
    @State private var incorrect_answer = 0

    @State private var isActive = false

    struct modelObject: Identifiable {
        var id = UUID()
        var name: String = "nama object"
        var img: String = "object_default"
    }

    struct modelObjectQuestion: Identifiable {
        var id: Int = 0
        var x: Int = 0
        var y: Int = 0
        var location: CGPoint = .init(x: 0, y: 0)
        var isDragging = false
        var status = false
    }

    struct modelAnswerOption: Identifiable {
        var id: Int = 0
        var option: Int = 0
        var status = false
    }

    struct modelAnswerSelected: Identifiable {
        var id: Int = 0
        var option: Int = 0
        var status = false
    }

    func answerCheck(option: Int) {
        check_answer = true
        option_selected = option
        if result == option {
            getHapticsNotify(.success)
            playSound(audioName: "correct.mp3")
            correct_answer += 1
            img = "rahmath_2"

            answer_status = true
            arr_answer_selected.append(modelAnswerSelected(option: option_selected, status: true))
        } else {
            getHapticsNotify(.warning)
            playSound(audioName: "incorrect.mp3")
            incorrect_answer += 1
            img = "rahmath_3"
            answer_status = false
            arr_answer_selected.append(modelAnswerSelected(option: option_selected, status: false))
        }
        if num_question == limit_question {
            calculate_badge()
        }
        print("Answer Check : " + String(check_answer))
    }

    func calculate_badge() {
        if correct_answer == 4 {
            badge1 += 1
        } else if correct_answer == 3 {
            badge_2 += 1
        } else if correct_answer == 2 {
            badge_3 += 1
        }
        total_correct += correct_answer
        total_incorrect += incorrect_answer
        total_question += num_question
    }

    func reset() {
        index = 0
        result = 0
        img = "rahmath_1"
        check_answer = false
        arr_object_question_1.removeAll()
        arr_object_question_2.removeAll()
    }

    func play() {
        getHapticsNotify(.success)

        num_question += 1
        reset()
        print("Question : " + String(num_question))
        print("Limit : " + String(limit_question))
        print("Answer Check : " + String(check_answer))

        if CGFloat(num_question) / CGFloat(limit_question) <= 0.5 {
            op = "+"
            op_icon = "plus.circle"
            num_1 = Int.random(in: 1 ..< 5)
            num_2 = Int.random(in: 1 ..< 5)

            result = num_1 + num_2

        } else {
            op = "-"
            op_icon = "minus.circle"
            num_1 = Int.random(in: 1 ..< 5)
            num_2 = Int.random(in: 0 ..< num_1)
            if num_2 == 0 {
                num_2 = 1
            }

            result = num_1 - num_2
        }

        var x = 40
        var y = 40
        for i in 0 ... (num_1 - 1) {
            arr_object_question_1.append(modelObjectQuestion(id: index, x: x, y: y, location: CGPoint(x: x, y: y), isDragging: false))
            x += 60
            if i > 0, i % 2 != 0 {
                y += 60
                x = 40
            }
            index += 1
        }

        x = 40
        y = 40
        for i in 0 ... (num_2 - 1) {
            arr_object_question_2.append(modelObjectQuestion(id: index, x: x, y: y, location: CGPoint(x: x, y: y), isDragging: false))
            x += 60
            if i > 0, i % 2 != 0 {
                y += 60
                x = 40
            }
            index += 1
        }

        index = Int.random(in: 0 ..< 4)
        arr_answer_option[index] = modelAnswerOption(id: index, option: result)

        for i in 0 ... 3 where i != index {
                for _ in 0 ... 100 {
                    let option = Int.random(in: 1 ..< 9)
                    if option != arr_answer_option[0].option,
                       option != arr_answer_option[1].option,
                       option != arr_answer_option[2].option,
                       option != arr_answer_option[3].option {
                        arr_answer_option[i] = modelAnswerOption(id: i, option: option)
                        break
                    }
                }
        }
        index = Int.random(in: 0 ..< arr_object.count)
        object_selected = arr_object[index]
    }

    @State var isPop: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        Text("Question #" + String(num_question)
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
                            .frame(width: (screenWidth - 40) * (CGFloat(num_question) / CGFloat(limit_question)), height: 24).cornerRadius(20)
                            .padding(.bottom, 10)
                            .foregroundColor(Color("colorGreen"))
                    }
                    HStack {
                        ZStack {
                            Rectangle().frame(height: 150).cornerRadius(46).foregroundColor(Color("colorBlue"))
                            ForEach(arr_object_question_1) { val in
                                Image(object_selected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50).shadow(radius: 4, x: 4, y: 4).position(val.location)
                            }

                            ZStack {
                                Circle()
                                    .foregroundColor(Color("colorWhite")
                                        .opacity(0.5))
                                    .frame(height: 40)
                                Text(String(num_1))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite")).frame(height: 40)
                            }.offset(y: 50)
                        }
                        Image(systemName: op_icon)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("colorBlue"))
                            .frame(width: 50)
                        ZStack {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorBlue"))
                            ForEach(arr_object_question_2) { val in
                                Image(object_selected.img)
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
                                Text(String(num_2))
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

                        if check_answer == true, num_question < limit_question {
                            Button {
                                if num_question < limit_question {
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
                        } else if check_answer == true, num_question >= limit_question {

                            Button {
                                isActive = true
                            } label: {
                                Text("Check Your Result")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .navigationDestination(isPresented: $isActive) {
                                ResultView(correctAnswer: correct_answer, numberOfQuestion: num_question)
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
                        if check_answer == false {
                            HStack(spacing: 30) {
                                ForEach(0 ..< 2) { index in
                                    Button {
                                            answerCheck(option: arr_answer_option[index].option)
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30).foregroundColor(Color("colorWhite")).shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(arr_answer_option[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }
                                    }
                                }
                            }
                            HStack(spacing: 30) {
                                ForEach(2 ..< 4) { index in
                                    Button {
                                            answerCheck(option: arr_answer_option[index].option)
                                        }
                                label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(arr_answer_option[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }
                                    }
                                }
                            }
                        } else {
                            HStack(spacing: 30) {
                                ForEach(0 ..< 2) { index in
                                    if arr_answer_option[index].option == option_selected {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 90)
                                                .cornerRadius(30)
                                                .foregroundColor(answer_status == true ? Color("colorGreen") : Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorBlue"), lineWidth: 5))
                                                .padding(2)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorWhite"), lineWidth: 3))
                                            Text(String(arr_answer_option[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(1)
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(arr_answer_option[index].option == result ? Color("colorGreen") : Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(arr_answer_option[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(arr_answer_option[index].option == result ? 1 : 0.4)
                                    }
                                }
                            }
                            HStack(spacing: 30) {
                                ForEach(2 ..< 4) { index in
                                    if arr_answer_option[index].option == option_selected {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 90)
                                                .cornerRadius(30)
                                                .foregroundColor(answer_status == true ? Color("colorGreen") : Color("colorWhite")).shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorBlue"), lineWidth: 5))
                                                .padding(2)
                                                .overlay(RoundedRectangle(cornerRadius: 30)
                                                    .strokeBorder(Color("colorWhite"), lineWidth: 3))
                                            Text(String(arr_answer_option[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(1)
                                    } else {
                                        ZStack {
                                            Rectangle()
                                                .frame(height: 95)
                                                .cornerRadius(30)
                                                .foregroundColor(arr_answer_option[index].option == result ? Color("colorGreen") : Color("colorWhite"))
                                                .shadow(color: Color("colorBlueDark"), radius: 0, x: 1, y: 5)
                                            Text(String(arr_answer_option[index].option))
                                                .font(.system(size: 50, weight: .heavy, design: .rounded))
                                                .foregroundColor(Color("colorBlack"))
                                        }.opacity(arr_answer_option[index].option == result ? 1 : 0.4)
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
