//
//  ContentView.swift
//  rahmathios
//
//  Created by Aang Muammar Zein on 30/03/23.
//

import SwiftUI

enum AnimationState {
    case compress
    case expand
    case normal
}

struct OnboardingView: View {
    
    @State private var presentedParks: [Park] = []
    
    struct Park:Identifiable{
        var id = UUID()
        var value:String = ""
    }
    
    @State private var screenWidth = UIScreen.main.bounds.size.width
    @State private var screenHeight = UIScreen.main.bounds.size.height
    
    @State private var animationState: AnimationState = .normal
    @State private var done: Bool = false
    
    func calculate() -> Double {
        switch animationState {
        case .compress:
            return 0.78
        case .expand:
            return 10.0
        case .normal:
            return 0.7
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack(){
                VStack(){
                    ZStack(){
                        ZStack(){
                            Circle().frame(height:250).foregroundColor(Color("colorWhite")).opacity(0.2).offset(x:(screenWidth * -1)/2,y:(screenHeight * -1)/6)
                            Circle().frame(height:350).foregroundColor(Color("colorWhite")).opacity(0.2).offset(x:(screenWidth * 1)/3.5,y:(screenHeight * 1)/6)
                        }
                        
                        
                        VStack(){
                            HStack(){
                                Text("I'm ").font(.system(size: 32,weight: .light,design: .rounded)).foregroundColor(Color("colorWhite"))
                                Text("Rahmath!").font(.system(size: 32,weight: .bold,design: .rounded)).foregroundColor(Color("colorWhite"))
                                
                            }
                            Image("logo")
                                .resizable().scaledToFit().frame(width: screenWidth/2).shadow(color: .black, radius: 2, x: 3, y: 3)
                        }
                    }.frame(maxWidth: .infinity,maxHeight: screenHeight/2).background(Color("colorBlue"))
                    VStack(spacing:20){
                        Text("Matematika Berkah!").font(.system(size: 32,weight: .bold,design: .rounded)).foregroundColor(Color("colorBlack"))
                        Text("Let's understand math. Learn with us!").font(.system(size: 20,weight: .light,design: .rounded)).foregroundColor(Color("colorBlack")).multilineTextAlignment(.center).padding(.bottom,50)
                        
                        NavigationLink(destination: SelectHeroView().navigationBarBackButtonHidden(true)) {
                            Text("Next").padding(3)
                                .font(.system(size: 20,weight:.regular ,design: .rounded)).padding(8).frame(maxWidth: .infinity).shadow(radius: 0,x:0,y:0)
                            
                        }.buttonStyle(.borderedProminent).frame(maxWidth:.infinity)
                            .buttonBorderShape(.capsule).compositingGroup()  .shadow(color:Color("colorRedDark"),radius: 0,x:1,y:5).padding(.top,20)
                        
                    }.padding(.leading,20).padding(.trailing,20).frame(maxWidth: .infinity,maxHeight: screenHeight/2).background(Color("colorWhite")).cornerRadius(40).padding(.bottom,-50)
                }.frame(maxWidth: .infinity,maxHeight: screenHeight).background(Color("colorBlue"))
                
                VStack {
                    Image("logo_rahmath")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(calculate()).shadow(radius: 4,x:4,y:4)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("colorBlue"))
                .opacity(done ? 0 : 1)
            }
            
        }
        .onAppear {
            if(music_status==true){
                playMusic()
            }else{
                stopMusic()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring()) {
                    animationState = .compress
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.spring()) {
                            animationState = .expand
                            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0)) {
                                done = true
                            }
                        }
                    }
                }
                
            }
        }
        
    }
}


struct OnboardingViewView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
