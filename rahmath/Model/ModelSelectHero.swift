//
//  ModelSelectHero.swift
//  Rahmath
//
//  Created by Mutiara Ruci on 22/08/23.
//

import Foundation

struct HeroModel: Identifiable {
    var id: String = UUID().uuidString
    var name: String = ""
    var img: String = "avatar_default"
    var color: String = "colorBlue"
    var status = false
}
