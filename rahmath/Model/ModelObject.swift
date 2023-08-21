//
//  ModelObject.swift
//  Rahmath
//
//  Created by Mutiara Ruci on 21/08/23.
//

import Foundation

struct ModelObject: Identifiable {
    var id = UUID()
    var name: String = "nama object"
    var img: String = "object_default"
    var mp3: String = "object_default.mp3"
}
