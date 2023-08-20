//
//  TutorialView.swift
//  freedom
//
//  Created by Aang Muammar Zein on 31/03/23.
//

import AVFoundation
import SwiftUI

struct TutorialView: View {
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    @State private var objects: [ModelObject] = [
        ModelObject(name: "apple", img: "object_apple", mp3: "object_apple.mp3"),
        ModelObject(name: "egg", img: "object_egg", mp3: "object_egg.mp3"),
        ModelObject(name: "pencil", img: "object_pencil", mp3: "object_pencil.mp3"),
        ModelObject(name: "donut", img: "object_donut", mp3: "object_donut.mp3"),
        ModelObject(name: "peanut", img: "object_peanut", mp3: "object_peanut.mp3"),
        ModelObject(name: "ball", img: "object_ball", mp3: "object_ball.mp3"),
        ModelObject(name: "avocado", img: "object_avocado", mp3: "object_avocado.mp3"),
        ModelObject(name: "ice cream", img: "object_icecream", mp3: "object_icecream.mp3"),
        ModelObject(name: "cake", img: "object_cake", mp3: "object_cake.mp3"),
        ModelObject(name: "eyeglasses", img: "object_eyeglasses", mp3: "object_eyeglasses.mp3")
    ]
    @State private var objectSelected = ModelObject()
    @State private var objectQuestion1: [ModelObjectQuestion] = []
    @State private var objectQuestion2: [ModelObjectQuestion] = []
    @State private var answerOptions: [ModelAnswerOption] = [
        ModelAnswerOption(),
        ModelAnswerOption(),
        ModelAnswerOption(),
        ModelAnswerOption()
    ]
    @State private var answersSelected: [ModelAnswerSelected] = []
    @State private var img = "rahmath_1"
    @State private var num1 = 0
    @State private var num2 = 0
    @State private var op = "+"
    @State private var operatorIcon = "plus.circle"
    @State private var result = 0
    @State private var index = 0
    @State private var limitQuestion = 4
    @State private var checkAnswer = false
    @State private var typeSays: String = ""
    @State private var numQuestion = 0
    @State private var answerStatus = false
    @State private var optionSelected = 0
    @State private var correctAnswer = 0
    @State private var incorrectAnswer = 0
    @State private var totalObject = 0
    @State private var totalObjectInBasket = 0
    @State private var totalObjectInBox2 = 0
    @State private var inBasketStatus = false
    @State private var checkTutorial = false
    @State private var saysGreat = false
    @State private var xTargetMin = 100
    @State private var xTargetMax = 250
    @State private var yTargetMin = 280
    @State private var yTargetMax = 420

    @State private var xTarget2Min = 200
    @State private var xTarget2Max = 340
    @State private var yTarget2Min = 0
    @State private var yTarget2Max = 140

    @State private var text = ""

    @State private var isActive = false

    @State private var arrSays: [String] = []

    struct ModelObject: Identifiable {
        var id = UUID()
        var name: String = "nama object"
        var img: String = "object_default"
        var mp3: String = "object_default.mp3"
    }

    struct ModelObjectQuestion: Identifiable {
        var id: Int = 0
        var x: Int = 0
        var y: Int = 0
        var location: CGPoint = .init(x: 0, y: 0)
        var isDragging = false
        var status = false
        var statusMinus = false
    }

    struct ModelAnswerOption: Identifiable {
        var id: Int = 0
        var option: Int = 0
        var status = false
    }

    struct ModelAnswerSelected: Identifiable {
        var id: Int = 0
        var option: Int = 0
        var status = false
    }

    func reset() {
        index = 0
        result = 0
        img = "rahmath_1"
        checkAnswer = false
        inBasketStatus = false
        objectQuestion1.removeAll()
        objectQuestion2.removeAll()
    }

    func playSays() {
        if typeSays == "1" {
            arrSays.removeAll()
            arrSays = ["drag_the.mp3", objectSelected.mp3, "to_the_basket.mp3"]
            playSoundMultiple(audioName: arrSays)
        } else if typeSays == "2" {
            arrSays.removeAll()
            let numberMp3 = numberToMp3(number: num2)
            arrSays = ["great.mp3", "now_drag.mp3", numberMp3, objectSelected.mp3, "box.mp3"]
            playSoundMultiple(audioName: arrSays)
        } else if typeSays == "3" {
            arrSays.removeAll()
            arrSays = ["correct.mp3"]
            playSoundMultiple(audioName: arrSays)
        }
    }

    func play() {
        getHapticsNotify(.success)

        totalObjectInBasket = 0
        totalObjectInBox2 = 0

        checkTutorial = false
        numQuestion += 1
        reset()

        if CGFloat(numQuestion) / CGFloat(limitQuestion) <= 0.5 {
            op = "+"
            operatorIcon = "plus.circle"
            num1 = Int.random(in: 1 ..< 5)
            num2 = Int.random(in: 1 ..< 5)
            totalObject = num1 + num2

            result = num1 + num2

            var x = 40
            var y = 40

            for i in 0 ... (num1 - 1) {
                objectQuestion1.append(
                    ModelObjectQuestion(id: index, x: x, y: y, location: CGPoint(x: x, y: y), isDragging: false))
                x += 60
                if i > 0, i % 2 != 0 {
                    y += 60
                    x = 40
                }
                index += 1
            }
            x = 45
            y = 45
            for i in 0 ... (num2 - 1) {
                objectQuestion2.append(
                    ModelObjectQuestion(id: index, x: x, y: y, location: CGPoint(x: x, y: y), isDragging: false))
                x += 60
                if i > 0, i % 2 != 0 {
                    y += 60
                    x = 40
                }
                index += 1
            }

        } else {
            op = "-"
            operatorIcon = "minus.circle"
            operatorIcon = "minus.circle"
            num1 = Int.random(in: 1 ..< 5)
            num2 = Int.random(in: 0 ..< num1)
            if num2 == 0 {
                num2 = 1
            }
            totalObject = num1

            result = num1 - num2

            var x = 40
            var y = 40
            if num1 < 5 {
                for i in 0 ... (num1 - 1) {
                    objectQuestion1.append(
                        ModelObjectQuestion(id: index, x: x, y: y, location: CGPoint(x: x, y: y), isDragging: false))
                    x += 60
                    if i > 0, i % 2 != 0 {
                        y += 60
                        x = 40
                    }
                    index += 1
                }
            } else {
                for i in 0 ... 3 {
                    objectQuestion1.append(
                        ModelObjectQuestion(id: index, x: x, y: y, location: CGPoint(x: x, y: y), isDragging: false))
                    x += 60
                    if i > 0, i % 2 != 0 {
                        y += 60
                        x = 40
                    }
                    index += 1
                }
                x = 45
                y = 45
                for i in 4 ... (num1 - 1) {
                    objectQuestion1.append(
                        ModelObjectQuestion(id: index, x: x, y: y, location: CGPoint(x: x, y: y), isDragging: false))
                    x += 60
                    if i > 0, i % 2 != 0 {
                        y += 60
                        x = 40
                    }
                    index += 1
                }
            }
        }

        index = Int.random(in: 0 ..< 4)
        answerOptions[index] = ModelAnswerOption(id: index, option: result)

        for i in 0 ... 3 where i != index {
            for _ in 0 ... 100 {
                let option = Int.random(in: 1 ..< 9)
                if option != answerOptions[0].option,
                    option != answerOptions[1].option, option != answerOptions[2].option,
                    option != answerOptions[3].option {
                    answerOptions[i] = ModelAnswerOption(id: i, option: option)
                    break
                }
            }
        }
        index = Int.random(in: 0 ..< objects.count)
        objectSelected = objects[index]

        typeSays = "1"
        text = "Drag the " + objectSelected.name + " to the basket! "
        playSays()
    }

    func setLocationStatus(index: Int, value: DragGesture.Value, num: Int) -> Bool {
        if Int(value.location.x) >= xTargetMin - num,
           Int(value.location.x) <= xTargetMax - num,
           Int(value.location.y) >= yTargetMin,
           Int(value.location.y) <= yTargetMax {
            return true
        }
        return false
    }

    func setLocationStatusMinus(index: Int, value: DragGesture.Value, num: Int) -> Bool {
        if Int(value.location.x) >= xTarget2Min - num,
           Int(value.location.x) <= xTarget2Max - num,
           Int(value.location.y) >= yTarget2Min,
           Int(value.location.y) <= yTarget2Max {
            return true
        }
        return false
    }

    func countTotalStatus() -> Int {
        var total = 0
        objectQuestion1.forEach { result in
            if result.status == true {
                total += 1
            }
        }

        objectQuestion2.forEach { result in
            if result.status == true {
                total += 1
            }
        }

        return total
    }

    func countTotalStatusMinus() -> Int {
        var total = 0
        objectQuestion1.forEach { result in
            if result.statusMinus == true {
                total += 1
            }
        }

        objectQuestion2.forEach { result in
            if result.statusMinus == true {
                total += 1
            }
        }

        return total
    }

    func dragElement(index: Int, que: Int) -> some Gesture {
        DragGesture()
            .onChanged { value in
                typeSays = ""
                getHaptics(.soft)
                if que == 1 {
                    objectQuestion1[index].location = value.location
                    objectQuestion1[index].isDragging = true
                    objectQuestion1[index].status = setLocationStatus(index: index, value: value, num: 0)
                } else {
                    objectQuestion2[index].location = value.location
                    objectQuestion2[index].isDragging = true
                    objectQuestion2[index].status = setLocationStatus(index: index, value: value, num: 200)
                }

                if op == "+" {
                    let total = countTotalStatus()

                    totalObjectInBasket = total
                    if total == result {
                        typeSays = "3"
                        checkTutorial = true
                        text = "Yeaayy!! " + String(num1) + " + " + String(num2) + " = " + String(result)
                    } else {
                        typeSays = "1"
                        checkTutorial = false
                        text = "Drag the " + objectSelected.name + " to the basket! "
                    }
                } else if op == "-" {
                    let total = countTotalStatus()
                    totalObjectInBasket = total

                    if total == totalObject {
                        inBasketStatus = true
                    } else {
                        typeSays = "1"
                        checkTutorial = false
                        text = "Drag the " + objectSelected.name + " to the basket! "
                    }
                    if inBasketStatus == true {
                        if que == 1 {
                            objectQuestion1[index].location = value.location
                            objectQuestion1[index].isDragging = true
                            objectQuestion1[index].statusMinus = setLocationStatusMinus(
                                index: index,
                                value: value,
                                num: 0)

                        } else {
                            objectQuestion2[index].location = value.location
                            objectQuestion2[index].isDragging = true
                            objectQuestion2[index].statusMinus = setLocationStatusMinus(
                                index: index,
                                value: value,
                                num: 200)
                        }

                        let total2 = countTotalStatusMinus()
                        totalObjectInBox2 = total2

                        if totalObjectInBox2 == num2 {
                            if totalObjectInBasket == result {
                                typeSays = "3"
                                text = "Yeaayy!! " + String(num1) + " - " + String(num2) + " = " + String(result)
                                checkTutorial = true
                            } else {
                                typeSays = ""
                                text = "Make sure there are no " + objectSelected.name + " outside the basket!"
                                checkTutorial = false
                            }
                        } else if totalObjectInBasket == result {
                            if totalObjectInBox2 == num2 {
                                typeSays = "3"
                                text = "Yeaayy!! " + String(num1) + " - " + String(num2) + " = " + String(result)
                                checkTutorial = true
                            } else {
                                typeSays = "2"
                                text = "Great! Now drag " + String(num2) + " " + objectSelected.name + " to the top right box! "
                                checkTutorial = false
                            }
                        } else {
                            typeSays = "2"
                            text = "Great! Now drag " + String(num2) + " " + objectSelected.name + " to the top right box! "
                            checkTutorial = false
                        }
                    }
                }
            }
            .onEnded { _ in
                if que == 1 {
                    objectQuestion1[index].isDragging = false
                } else {
                    objectQuestion2[index].isDragging = false
                }
                if checkTutorial == true {
                    typeSays = "3"
//                    playSound(file_name: "correct.mp3")
                }
                playSays()
            }
    }

    @State var isPop: Bool = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ZStack {
                    Image("basket_2").resizable().scaledToFit().frame(height: 200)
                }.zIndex(3).padding(.bottom, 200)
                ZStack {
                    Circle().foregroundColor(Color("colorBlue").opacity(0.9)).frame(height: 40).padding(.top, 70)
                    Text(String(totalObjectInBasket))
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
                        Text(text)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .padding(.bottom, 30)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                            .onTapGesture {
                            playSays()
                        }
                        if checkTutorial == true, numQuestion < limitQuestion {
                            Button {
                                if numQuestion < limitQuestion {
                                    play()

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
                        } else if checkTutorial == true, numQuestion >= limitQuestion {
                            Button {
                                isActive = true
                            } label: {
                                Text("Back to Home")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .padding()
                                    .frame(maxWidth: .infinity)
                            }
                            .navigationDestination(isPresented: $isActive) {
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
                            ForEach(objectQuestion1) { val in
                                Image(objectSelected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: val.isDragging == true ? 75 : 50)
                                    .shadow(radius: 4, x: 4, y: 4)
                                    .position(val.location)
                                    .gesture(dragElement(index: val.id, que: 1))
                            }

                        }.zIndex(1)
                        Image(systemName: operatorIcon)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("colorWhite"))
                            .padding(.top, 40).frame(width: 50)
                            .opacity(0)
                        ZStack(alignment: .top) {
                            ForEach(objectQuestion2) { val in
                                Image(objectSelected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: val.isDragging == true ? 75 : 50)
                                    .shadow(radius: 4, x: 4, y: 4)
                                    .position(val.location)
                                    .gesture(dragElement(index: val.id - num1, que: 2))
                            }
                        }
                        .zIndex(1)
                    }
                }
                .zIndex(6)
                    .padding(.leading, 20).padding(.trailing, 20).padding(.top, 130)

                ZStack {
                    if checkTutorial == true {
                        ExplodingView()
                    }
                    HStack(alignment: .top) {
                        ZStack(alignment: .top) {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorWhite")
                                    .opacity(0.3))
                            ForEach(objectQuestion1) { val in
                                Image(objectSelected.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .position(val.location)
                                    .opacity(0)
                            }
                            ZStack {
                                Circle().foregroundColor(Color("colorBlue").opacity(0.9)).frame(height: 40)
                                Text(String(num1))
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(Color("colorWhite"))
                                    .frame(height: 40)
                            }.offset(y: 50)
                        }
                        Image(systemName: operatorIcon)
                            .font(.system(size: 50, weight: .bold))
                            .foregroundColor(Color("colorWhite"))
                            .padding(.top, 40).frame(width: 50)
                        ZStack(alignment: .top) {
                            Rectangle()
                                .frame(height: 150)
                                .cornerRadius(46)
                                .foregroundColor(Color("colorWhite")
                                    .opacity(0.3))
                            ForEach(objectQuestion2) { val in
                                Image(objectSelected.img)
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
                                Text(String(num2))
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
                        Text("Tutorial #" + String(numQuestion)
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
                            .frame(width: (screenWidth - 40) * (CGFloat(numQuestion) / CGFloat(limitQuestion)), height: 24)
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
                    .frame(height: screenHeight - 350)
                    .padding(.bottom, -50)
                    .zIndex(2)

            }.onAppear {
                play()
            }
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
