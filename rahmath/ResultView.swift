//
//  ResultView.swift
//  rahmath
//
//  Created by Aang Muammar Zein on 01/04/23.
//

import SwiftUI
import AVFoundation

struct ResultView: View {
    var correct_answer:Int
    var num_question:Int
    @State private var img = "sad"
    @State private var text = "Congrats!"
    @State private var text_2 = "You earn new badge!"
    @State private var text_3 = "One step closer to be the king of Math, Gain more badge to be great!"
    @State private var isActive = false
    
    
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    
    
    
    func play(){
        if(correct_answer > 1){
            playSound(file_name: "complete.mp3")
        }else{
            playSound(file_name: "incomplete.mp3")
        }
        if(correct_answer == 4){
            img = "crown"
        }else if(correct_answer == 3){
            img = "diamond"
        }else if(correct_answer == 2){
            img = "donut"
        }else{
            text = "Fail!"
            text_2 = "You don't earn new badge!"
            text_3 = "One step closer to be the king of Math, Gain more badge to be great!"
        }
    }
    
    
    
    var body: some View {
        NavigationStack{
            
            ScrollView(showsIndicators:false){
                Color("colorBlue")
                VStack(spacing:10){
                    Text(text).font(.system(size: 48,weight: .heavy,design: .rounded))
                    
                    
                    
                    ZStack() {
                        
                        ExplodingView().zIndex(10)
                        Circle().foregroundColor(Color("colorGreen")).frame(width: 250).blur(radius: 50)
                        Image(img)
                            .resizable().scaledToFit().frame(width: 150).shadow(color: .black, radius: 2, x: 3, y: 3)
                        Image("hero_selected_badge")
                            .resizable().scaledToFit().frame(width: 280)
                            .shadow(color: .black, radius: 2, x: 3, y: 3)
                        
                        
                    }
                    
                    
                    HStack(){
                        ZStack(){
                            Circle().frame(height:50).foregroundColor(Color("colorGreen"))
                            Text(String(correct_answer)).font(.system(size: 24,weight: .bold,design: .rounded))
                        }
                        Text("Answer Correct!").font(.system(size: 20,weight: .regular,design: .rounded))
                    }
                    Text(text_2).font(.system(size: 24,weight: .bold,design: .rounded)).multilineTextAlignment(.center)
                    Text(text_3).font(.system(size: 18,weight: .light,design: .rounded)).multilineTextAlignment(.center)
                    
                    
                    NavigationLink(destination: ExerciseView().navigationBarBackButtonHidden(true), isActive: $isActive) {
                        
                        Text("Play again!").padding(3)
                            .font(.system(size: 20,weight:.regular ,design: .rounded)).padding(8).frame(maxWidth: .infinity)
                        
                    }.buttonStyle(.borderedProminent).frame(maxWidth:.infinity)
                        .buttonBorderShape(.capsule).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5).padding(.top,20)
                    
                    NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                        Text("I'll come back later").font(.system(size: 18,weight: .light,design: .rounded)).foregroundColor(Color("colorBlack")).padding(.top,10)
                        
                    }
                    
                    
                    
                }.frame(maxWidth: screenWidth).padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20)).background(Color("colorWhite")).cornerRadius(40)
            }.padding(.leading,20).padding(.trailing,20).background(Color("colorBlue")).onAppear {
                play()
            }
        }.task {
            getHapticsNotify(.success)
            
        }
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(correct_answer: 3, num_question: 4)
    }
}
