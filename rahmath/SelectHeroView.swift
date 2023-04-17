//
//  ContentView.swift
//  rahmathios
//
//  Created by Aang Muammar Zein on 30/03/23.
//

import SwiftUI

struct SelectHeroView: View {
    @AppStorage("HERO_COLOR") var hero_color: String = "colorGreen"
    @AppStorage("HERO_IMG") var hero_img: String = "avatar_2"
    @AppStorage("HERO_ID") var hero_id: String = "1"
    @AppStorage("HERO_NAME") var hero_name: String = "Rahmath"
    
    @State var animate: Bool = false
    let animation: Animation = Animation.linear(duration: 5).repeatForever(autoreverses: false)
    @State var movingIcon: Bool = false
    
    @State private var arr_hero:[heroModel] = [
        heroModel(id:"1",name:"Octopus",img: "avatar_2",color:"colorGreen"),
        heroModel(id:"2",name:"Octopus",img: "avatar_1",color:"colorRed"),
        heroModel(id:"3",name:"Octopus",img: "avatar_5",color:"colorBlue"),
        heroModel(id:"4",name:"Octopus",img: "avatar_4",color:"colorGrey"),
        heroModel(id:"5",name:"Octopus",img: "avatar_5",color:"colorGreen"),
        heroModel(id:"6",name:"Octopus",img: "avatar_8",color:"colorRed"),
        heroModel(id:"7",name:"Octopus",img: "avatar_7",color:"colorBlue"),
        heroModel(id:"8",name:"Octopus",img: "avatar_6",color:"colorGrey"),
    ]
    @State private var hero_selected = heroModel(id:"1",name:"Octopus",img: "avatar_2",color:"colorGreen")
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    @State private var name = ""
    
    
    @State private var isActive = false
    
    struct heroModel:Identifiable{
        var id:String = UUID().uuidString
        var name:String = ""
        var img:String = "avatar_default"
        var color:String = "colorBlue"
        var status = false
    }
    func selectHero(index : Int){
        hero_selected = arr_hero[index]
        hero_color = hero_selected.color
        hero_img = hero_selected.img
        hero_id = hero_selected.id
        print(hero_selected)
    }
    var body: some View {
        NavigationStack{
            VStack {
                
                ZStack() {
                    Color(hero_color).edgesIgnoringSafeArea(.all)
                    Image("hero_selected")
                        .resizable().scaledToFit().frame(width: screenWidth/1.8)
                    Image(hero_img)
                        .resizable().scaledToFit().frame(width: screenWidth/2).shadow(color: .black, radius: 2, x: 3, y: 3).offset(x:0,y: movingIcon ? -5 : 0)
                        .animation(.spring(response: 1, dampingFraction: 0.0, blendDuration: 0.0).repeatForever(autoreverses: false), value: movingIcon).task {
                            movingIcon.toggle()
                        }
                    Image("hero_selected_badge")
                        .resizable().scaledToFit().frame(width: screenWidth/2)
                        .shadow(color: .black, radius: 2, x: 3, y: 3)
                    
                    
                }.onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                VStack(alignment: .leading){
                    Color("colorWhite").edgesIgnoringSafeArea(.all)
                    
                    //                Text("Hello, \(name)!").padding(.leading,20).padding(.bottom,10)
                    Text("Choose your hero").foregroundColor(Color.black)
                        .font(Font.system(size:20,design: .rounded).weight(.bold)).padding(.leading,20).padding(.top,30).padding(.bottom,0)
                    ScrollView(.horizontal,showsIndicators: false) {
                        
                        HStack(spacing: 10) {
                            ForEach((0..<arr_hero.count)) { index in
                                Button(action: {
                                    selectHero(index:index)
                                    getHapticsNotify(.success)
                                }) {
                                    ZStack() {
                                        if(hero_id == arr_hero[index].id){
                                            Circle() .fill(Color(arr_hero[index].color)).frame(width: screenWidth / 3.5, height: screenWidth/3.5)
                                            Circle() .fill(Color("colorWhite")).frame(width: screenWidth / 3.7, height: screenWidth/3.7)
                                        }else{
                                            Circle() .fill(Color("colorWhite")).frame(width: screenWidth / 4.5, height: screenWidth/4.5)
                                            Circle() .fill(Color("colorWhite")).frame(width: screenWidth / 4.7, height: screenWidth/4.7)
                                        }
                                        
                                        
                                        Circle()
                                            .fill(Color(arr_hero[index].color)).opacity(0.25).frame(width: screenWidth / 4, height: screenWidth/4)
                                        Image(arr_hero[index].img)
                                            .resizable().scaledToFit().frame(width: screenWidth/6).shadow(color: .black, radius: 2, x: 3, y: 3)
                                    }
                                }
                            }
                            
                        }
                        .padding(.leading,20).padding(.top,10)
                    }
                    
                    Text("Write your name").foregroundColor(Color.black)
                        .font(Font.system(size:20,design: .rounded).weight(.bold)).padding(.leading,20).padding(.top,20)
                    HStack(){
                        TextField("Write your name", text: $hero_name).padding(.leading,10)
                            .frame(height: 60)
                            .font(Font.system(size:18,design: .rounded).weight(.bold))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color("colorRed"),lineWidth: 3)).padding(.trailing,5).padding(.top,4)
                        
                        NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $isActive) {
                            Image(systemName: "play.fill")
                                .fontWeight(.bold).frame(width:50)
                                .font(Font.system(size:25,design: .rounded).weight(.bold))
                                .foregroundColor(Color("colorGreen"))
                                .padding()
                                .background(Color("colorRed")).cornerRadius(15).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5)
                            
                        }
                        
                    }.padding(EdgeInsets(top: 10, leading: 20, bottom: 50, trailing: 20))
                    
                }.background(Color("colorWhite")) .cornerRadius(50).padding(.top,-50)
            }
            
        }.task{
            getHapticsNotify(.success)
        }
    }
}


struct SelectHeroView_Previews: PreviewProvider {
    static var previews: some View {
        SelectHeroView()
    }
}
