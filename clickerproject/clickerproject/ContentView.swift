//
//  ContentView.swift
//  clickerproject
//
//  Created by Mimi Chen on 9/4/25.
//

import SwiftUI

struct Achievement {
    let threshold: Int
    let message: String
    let catMood: String
}

struct GameState {
    var clickCount: Int=0
    var currentMessage: String = "pets please!"
    var showSpeechBubble: Bool = true
    var catMood: String = "😺"
}


//main game view
struct ContentView: View{
    @State private var gameState = GameState()
    @State private var speechBubbleTimer: Timer?
    
    private let achievements: [Achievement] = [
        Achievement(threshold: 1, message: "purr...", catMood: "😸"),
        Achievement(threshold: 5, message: "meow, thank you!", catMood: "😻"),
        Achievement(threshold: 8, message: "meow meow meow...", catMood: "😽"),
        Achievement(threshold: 12, message: "meow, that is enough!!!", catMood: "😾")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.3), .pink.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            .ignoresSafeArea()
            
            VStack(spacing: 48){
                VStack(spacing: 8){
                    Text("cat petting game")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(.purple)
                    Text("'click' the cat to pet")
                        .font(.system(size: 20, design: .default))
                        .foregroundColor(.purple)
                }
                
                VStack{
                    Text("pet count: \(gameState.clickCount)")
                        .font(.title2)
                    
                    if gameState.showSpeechBubble {
                        Text(gameState.currentMessage)
                            .font(.system(size: 24))
                            .italic(true)
                            .foregroundColor(.purple)
                            .padding()
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(10)
                    }
                    
                    Button(action: handleCatTap) {
                        Text(gameState.catMood)
                            .font(.system(size: 80))
                            .padding(24)
                            .background(.white.opacity(0.4))
                            .cornerRadius(1000)
                    }
                    
                    
                }
                Button("restart", action: resetGame)
                    .padding()
                    .border(Color.purple)
                    .foregroundStyle(.purple)
                    .font(.system(size: 18, weight: .bold))
            }
        }

    }

    func handleCatTap() {
        gameState.clickCount += 1
        checkAchievements()
        
        gameState.showSpeechBubble = true
        speechBubbleTimer?.invalidate()
        
        speechBubbleTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            withAnimation {
                gameState.showSpeechBubble = false
            }
        }
    }
    func checkAchievements() {
        for achievement in achievements.reversed() {
            if gameState.clickCount >= achievement.threshold {
                gameState.currentMessage = achievement.message
                gameState.catMood = achievement.catMood
                return
            }
        }
    }
    func resetGame() {
        speechBubbleTimer?.invalidate()
        withAnimation {
            gameState=GameState()
        }
    }
}
    

#Preview {
    ContentView()
}
