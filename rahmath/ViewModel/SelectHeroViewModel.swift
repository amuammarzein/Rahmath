//
//  SelectHeroViewModel.swift
//  Rahmath
//
//  Created by Mutiara Ruci on 22/08/23.
//

import SwiftUI

class SelectHeroViewModel: ObservableObject {
    @AppStorage("HERO_COLOR") var heroColor: String = "colorGreen"
    @AppStorage("HERO_IMG") var heroImg: String = "avatar_2"
    @AppStorage("HERO_ID") var heroId: String = "1"
    @AppStorage("HERO_NAME") var heroName: String = "Rahmath"

    @Published var animate: Bool = false
    let animation: Animation = .linear(duration: 5).repeatForever(autoreverses: false)
    @Published var movingIcon: Bool = false

    @Published var heroes: [HeroModel] = [
        HeroModel(id: "1", name: "Octopus", img: "avatar_2", color: "colorGreen"),
        HeroModel(id: "2", name: "Octopus", img: "avatar_1", color: "colorRed"),
        HeroModel(id: "3", name: "Octopus", img: "avatar_5", color: "colorBlue"),
        HeroModel(id: "4", name: "Octopus", img: "avatar_4", color: "colorGrey"),
        HeroModel(id: "5", name: "Octopus", img: "avatar_5", color: "colorGreen"),
        HeroModel(id: "6", name: "Octopus", img: "avatar_8", color: "colorRed"),
        HeroModel(id: "7", name: "Octopus", img: "avatar_7", color: "colorBlue"),
        HeroModel(id: "8", name: "Octopus", img: "avatar_6", color: "colorGrey")
    ]
    @Published var heroSelected = HeroModel(id: "1", name: "Octopus", img: "avatar_2", color: "colorGreen")
    @Published var screenWidth = UIScreen.main.bounds.size.width
    @Published var screenHeight = UIScreen.main.bounds.size.height
    @Published var name = ""

    @Published var isActive = false

    func selectHero(index: Int) {
        heroSelected = heroes[index]
        heroColor = heroSelected.color
        heroImg = heroSelected.img
        heroId = heroSelected.id
        print(heroSelected)
    }
}
