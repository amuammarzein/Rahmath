//
//  ModelObjectQuestionExercise.swift
//  Rahmath
//
//  Created by Mutiara Ruci on 21/08/23.
//

import Foundation

struct ModelObjectQuestionExercise: Identifiable {
    var id: Int = 0
    var x: Int = 0
    var y: Int = 0
    var location: CGPoint = .init(x: 0, y: 0)
    var isDragging = false
    var status = false
}
