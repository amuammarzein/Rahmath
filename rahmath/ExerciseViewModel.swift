//
//  ExerciseViewModel.swift
//  Rahmath
//
//  Created by Mutiara Ruci on 21/08/23.
//

import SwiftUI

class ExerciseViewModel: ObservableObject {
    @AppStorage("BADGE_1") var badge1: Int = 0
    @AppStorage("BADGE_2") var badge2: Int = 0
    @AppStorage("BADGE_3") var badge3: Int = 0
    @AppStorage("TOTAL_CORRECT") var totalCorrect: Int = 0
    @AppStorage("TOTAL_INCORRECT") var totalIncorrect: Int = 0
    @AppStorage("TOTAL_QUESTION") var totalQuestion: Int = 0
    @Published var screenWidth = UIScreen.main.bounds.size.width
    @Published var screenHeight = UIScreen.main.bounds.size.height
    @Published var objects: [ModelObjectExercise] = [
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
    @Published var selectedObject = ModelObjectExercise()
    @Published var objectsQuestion1: [ModelObjectQuestionExercise] = []
    @Published var objectQuestion2: [ModelObjectQuestionExercise] = []
    @Published var optionsAnswer: [ModelAnswerQuestionExercise] = [
        ModelAnswerQuestionExercise(),
        ModelAnswerQuestionExercise(),
        ModelAnswerQuestionExercise(),
        ModelAnswerQuestionExercise()
    ]
    @Published var selectedAnswers: [ModelAnswerSelectedExercise] = []
    @Published var img = "rahmath_1"
    @Published var num1 = 0
    @Published var num2 = 0
    @Published var op = "+"
    @Published var operatorIcon = "plus.circle"
    @Published var result = 0
    @Published var index = 0
    @Published var questionLimit = 4
    @Published var checkAnswer = false
    @Published var questionNum = 0
    @Published var answerStatus = false
    @Published var optionSelected = 0
    @Published var correctAnswer = 0
    @Published var incorrectAnswer = 0

    @Published var isActive = false

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

}
