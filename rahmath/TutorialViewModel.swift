//
//  TutorialViewModel.swift
//  Rahmath
//
//  Created by Mutiara Ruci on 21/08/23.
//

import SwiftUI

class TutorialViewModel: ObservableObject {
    @Published var screenWidth = UIScreen.main.bounds.size.width
    @Published var screenHeight = UIScreen.main.bounds.size.height
    @Published var objects: [ModelObject] = [
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
    @Published var objectSelected = ModelObject()
    @Published var objectQuestion1: [ModelObjectQuestion] = []
    @Published var objectQuestion2: [ModelObjectQuestion] = []
    @Published var answerOptions: [ModelAnswerOption] = [
        ModelAnswerOption(),
        ModelAnswerOption(),
        ModelAnswerOption(),
        ModelAnswerOption()
    ]
    @Published var answersSelected: [ModelAnswerSelected] = []
    @Published var img = "rahmath_1"
    @Published var num1 = 0
    @Published var num2 = 0
    @Published var op = "+"
    @Published var operatorIcon = "plus.circle"
    @Published var result = 0
    @Published var index = 0
    @Published var limitQuestion = 4
    @Published var checkAnswer = false
    @Published var typeSays: String = ""
    @Published var numQuestion = 0
    @Published var answerStatus = false
    @Published var optionSelected = 0
    @Published var correctAnswer = 0
    @Published var incorrectAnswer = 0
    @Published var totalObject = 0
    @Published var totalObjectInBasket = 0
    @Published var totalObjectInBox2 = 0
    @Published var inBasketStatus = false
    @Published var checkTutorial = false
    @Published var saysGreat = false
    @Published var xTargetMin = 100
    @Published var xTargetMax = 250
    @Published var yTargetMin = 280
    @Published var yTargetMax = 420

    @Published var xTarget2Min = 200
    @Published var xTarget2Max = 340
    @Published var yTarget2Min = 0
    @Published var yTarget2Max = 140

    @Published var text = ""

    @Published var isActive = false

    @Published var arrSays: [String] = []

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
                self.typeSays = ""
                getHaptics(.soft)
                if que == 1 {
                    self.objectQuestion1[index].location = value.location
                    self.objectQuestion1[index].isDragging = true
                    self.objectQuestion1[index].status =
                    self.setLocationStatus(
                        index: index, value: value, num: 0
                    )
                } else {
                    self.objectQuestion2[index].location = value.location
                    self.objectQuestion2[index].isDragging = true
                    self.objectQuestion2[index].status = self.setLocationStatus(
                        index: index, value: value, num: 200
                    )
                }

                if self.op == "+" {
                    let total = self.countTotalStatus()

                    self.totalObjectInBasket = total
                    if total == self.result {
                        self.typeSays = "3"
                        self.checkTutorial = true
                        self.text =
                        "Yeaayy!! " + String(self.num1) +
                        " + " + String(self.num2) +
                        " = " + String(self.result)
                    } else {
                        self.typeSays = "1"
                        self.checkTutorial = false
                        self.text = "Drag the " + self.objectSelected.name + " to the basket! "
                    }
                } else if self.op == "-" {
                    let total = self.countTotalStatus()
                    self.totalObjectInBasket = total

                    if total == self.totalObject {
                        self.inBasketStatus = true
                    } else {
                        self.typeSays = "1"
                        self.checkTutorial = false
                        self.text = "Drag the " + self.objectSelected.name + " to the basket! "
                    }
                    if self.inBasketStatus == true {
                        if que == 1 {
                            self.objectQuestion1[index].location = value.location
                            self.objectQuestion1[index].isDragging = true
                            self.objectQuestion1[index].statusMinus = self.setLocationStatusMinus(
                                index: index,
                                value: value,
                                num: 0)

                        } else {
                            self.objectQuestion2[index].location = value.location
                            self.objectQuestion2[index].isDragging = true
                            self.objectQuestion2[index].statusMinus = self.setLocationStatusMinus(
                                index: index,
                                value: value,
                                num: 200)
                        }

                        let total2 = self.countTotalStatusMinus()
                        self.totalObjectInBox2 = total2

                        if self.totalObjectInBox2 == self.num2 {
                            if self.totalObjectInBasket == self.result {
                                self.typeSays = "3"
                                self.text = "Yeaayy!! " +
                                String(self.num1) +
                                " - " +
                                String(self.num2) +
                                " = " + String(self.result)
                                self.checkTutorial = true
                            } else {
                                self.typeSays = ""
                                self.text =
                                "Make sure there are no " +
                                self.objectSelected.name +
                                " outside the basket!"
                                self.checkTutorial = false
                            }
                        } else if self.totalObjectInBasket == self.result {
                            if self.totalObjectInBox2 == self.num2 {
                                self.typeSays = "3"
                                self.text = "Yeaayy!! " +
                                String(self.num1) + " - " +
                                String(self.num2) + " = " +
                                String(self.result)
                                self.checkTutorial = true
                            } else {
                                self.typeSays = "2"
                                self.text = "Great! Now drag " +
                                String(self.num2) + " "
                                + self.objectSelected.name +
                                " to the top right box! "
                                self.checkTutorial = false
                            }
                        } else {
                            self.typeSays = "2"
                            self.text = "Great! Now drag " +
                            String(self.num2) + " " +
                            self.objectSelected.name + " to the top right box! "
                            self.checkTutorial = false
                        }
                    }
                }
            }
            .onEnded { _ in
                if que == 1 {
                    self.objectQuestion1[index].isDragging = false
                } else {
                    self.objectQuestion2[index].isDragging = false
                }
                if self.checkTutorial == true {
                    self.typeSays = "3"
//                    playSound(file_name: "correct.mp3")
                }
                self.playSays()
            }
    }
}
