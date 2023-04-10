//
//  ContentView.swift
//  Learn
//
//  Created by Mohammad Azam on 3/30/22.
//
import SwiftUI

enum AnimationState {
    case compress
    case expand
    case normal
}

struct SplashView: View {
    
    @State private var animationState: AnimationState = .normal
    @State private var done: Bool = false
    
    func calculate() -> Double {
        switch animationState {
        case .compress:
            return 0.38
        case .expand:
            return 10.0
        case .normal:
            return 0.3
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Text("ABC")
                    .scaleEffect(done ? 1: 0.95)
                
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(calculate())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("colorBlue"))
                .opacity(done ? 0 : 1)
                
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                
            }
            .navigationBarHidden(done ? false: true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
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
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
