//
//  ContentView.swift
//  rahmathios
//
//  Created by Aang Muammar Zein on 30/03/23.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("SOUND_STATUS") var sound_status: Bool = true
    @AppStorage("SOUND_ICON") var sound_icon:String = "waveform"
    @AppStorage("MUSIC_STATUS") var music_status: Bool = true
    @AppStorage("MUSIC_ICON") var music_icon:String = "speaker.wave.2.fill"
    @AppStorage("VIBRATOR_STATUS") var vibrator_status: Bool = true
    @AppStorage("VIBRATOR_ICON") var vibrator_icon:String = "hand.raised.fill"
    
    
    @AppStorage("HERO_IMG") var hero_img: String = "avatar_2"
    @AppStorage("HERO_ID") var hero_id: String = "1"
    @AppStorage("HERO_NAME") var hero_name: String = "Rahmath"
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    
    @AppStorage("BADGE_1") var badge_1: Int = 0
    @AppStorage("BADGE_2") var badge_2: Int = 0
    @AppStorage("BADGE_3") var badge_3: Int = 0
    @AppStorage("TOTAL_CORRECT") var total_correct: Int = 0
    @AppStorage("TOTAL_INCORRECT") var total_incorrect: Int = 0
    @AppStorage("TOTAL_QUESTION") var total_question: Int = 0
    
    @State private var isActive = false
    
    @State var isPop:Bool = false
    
    var body: some View {
        NavigationStack(){
            ScrollView(showsIndicators:false){
                
                VStack(alignment: .leading){
                    
                    HStack(){
                        
                        NavigationLink(destination: SelectHeroView().navigationBarBackButtonHidden(true)) {
                            
                            ZStack(){
                                Circle().frame(height:60).foregroundColor(Color("colorWhite")).shadow( radius: 2, x: 3, y: 3)
                                Image(hero_img)
                                    .resizable().scaledToFit().frame(height:50).shadow( radius: 2, x: 3, y: 3)
                            }.padding(.trailing,10)
                            //                            Text("Hello, ").font(.system(size: 28,weight: .light,design: .rounded)).foregroundColor(Color("colorBlack"))
                            //                            Text(hero_name+"!").font(.system(size: 28,weight: .bold,design: .rounded)).foregroundColor(Color("colorBlack")).lineLimit(1)
                            VStack(alignment: .leading){
                                Text("Hello, ").font(.system(size: 20,weight: .light,design: .rounded)).foregroundColor(Color("colorBlack"))
                                Text(hero_name+"!").font(.system(size: 24,weight: .bold,design: .rounded)).foregroundColor(Color("colorBlack")).lineLimit(1)
                            }
                        }
                        Spacer()
                        SettingView(isPop: $isPop)
                        
                    }.padding(EdgeInsets(top: 20, leading: 20, bottom: 50, trailing: 20))
                    
                    
                    
                    VStack(){
                        VStack(alignment: .leading,spacing:20){
                            Text("My Badges").font(.system(size: 28,weight: .medium,design: .rounded)).foregroundColor(Color("colorBlack"))
                            HStack(){
                                VStack(spacing:20){
                                    VStack(spacing:20){
                                        ZStack(){
                                            Circle().frame(maxWidth: .infinity).foregroundColor(Color("colorWhite")).shadow( radius: 2, x: 3, y: 3)
                                            Image("crown")
                                                .resizable().scaledToFit().frame(height:40).shadow( radius: 2, x: 3, y: 3)
                                        }
                                        HStack(){
                                            Text(String(badge_1)).font(.system(size: 16,weight: .bold,design: .rounded)).foregroundColor(Color("colorWhite")).padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        }.frame(maxWidth:.infinity).background(Color("colorBlue")).cornerRadius(45)
                                        
                                    }.padding(15)
                                    
                                }.frame(maxWidth:.infinity).background(Color("colorBlue").opacity(0.5)).cornerRadius(45)
                                
                                VStack(spacing:20){
                                    VStack(spacing:20){
                                        ZStack(){
                                            Circle().frame(maxWidth: .infinity).foregroundColor(Color("colorWhite")).shadow( radius: 2, x: 3, y: 3)
                                            Image("diamond")
                                                .resizable().scaledToFit().frame(height:40).shadow( radius: 2, x: 3, y: 3)
                                        }
                                        HStack(){
                                            Text(String(badge_2)).font(.system(size: 16,weight: .bold,design: .rounded)).foregroundColor(Color("colorWhite")).padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        }.frame(maxWidth:.infinity).background(Color("colorBlue")).cornerRadius(45)
                                        
                                    }.padding(15)
                                    
                                }.frame(maxWidth:.infinity).background(Color("colorBlue").opacity(0.5)).cornerRadius(45)
                                
                                VStack(spacing:20){
                                    VStack(spacing:20){
                                        ZStack(){
                                            Circle().frame(maxWidth: .infinity).foregroundColor(Color("colorWhite")).shadow( radius: 2, x: 3, y: 3)
                                            Image("donut")
                                                .resizable().scaledToFit().frame(height:40).shadow( radius: 2, x: 3, y: 3)
                                        }
                                        HStack(){
                                            Text(String(badge_3)).font(.system(size: 16,weight: .bold,design: .rounded)).foregroundColor(Color("colorWhite")).padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                        }.frame(maxWidth:.infinity).background(Color("colorBlue")).cornerRadius(45)
                                        
                                    }.padding(15)
                                    
                                }.frame(maxWidth:.infinity).background(Color("colorBlue").opacity(0.5)).cornerRadius(45)
                                
                            }
                        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    }
                    .frame(maxWidth: .infinity).background(Color("colorWhite")).cornerRadius(15).padding(.leading,20).padding(.trailing,20)
                    
                    NavigationLink(destination: ExerciseView().navigationBarBackButtonHidden(true), isActive: $isActive) {
                        Text("Play").foregroundColor(Color("colorGreen")).padding(3)
                            .font(.system(size: 20,weight:.regular ,design: .rounded)).padding(8).frame(maxWidth: .infinity)
                        
                    }.buttonStyle(.borderedProminent).frame(maxWidth:.infinity)
                        .buttonBorderShape(.capsule).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5).padding(.top,60).padding(.leading,20).padding(.trailing,20)
                    
                    
                    
                    Text("Learn the tutorial down here!").foregroundColor(Color("colorWhite"))
                        .font(.system(size: 20,weight:.regular ,design: .rounded)).padding(.top,40).padding(.leading,20).padding(.trailing,20)
                        .frame(maxWidth: .infinity).multilineTextAlignment(.center)
                    
                    
                    NavigationLink(destination: TutorialView().navigationBarBackButtonHidden(true)) {
                        Text("Tutorial").padding(3)
                            .font(.system(size: 20,weight:.regular ,design: .rounded)).padding(8).frame(maxWidth: .infinity)
                        
                    }.buttonStyle(.borderedProminent).frame(maxWidth:.infinity)
                        .buttonBorderShape(.capsule).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5).padding(.top,10).padding(.leading,20).padding(.trailing,20)
                }
            }.frame(maxWidth: .infinity,maxHeight: .infinity).background(Color("colorBlue")) 
        }.task {
            getHapticsNotify(.success)
            
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
