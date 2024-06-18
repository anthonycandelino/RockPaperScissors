//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anthony Candelino on 2024-06-14.
//

import SwiftUI

struct ButtonOption: View {
    var icon: String
    var label: String
    var body: some View {
        VStack {
            Text(icon).font(.system(size: UIScreen.main.bounds.height/12)).shadow(radius: 2)
            Text(label).bold().foregroundStyle(.black)
        }
    }
}

struct ContentView: View {
    private let winningOptions = ["🪨": "📄", "📄": "✂️", "✂️": "🪨"]
    private let losingOptions = ["🪨": "✂️", "📄": "🪨", "✂️": "📄"]
    @State private var optionsIcons = ["🪨", "📄", "✂️"]
    @State private var options = ["Rock", "Paper", "Scissors"]
    @State private var gameOption = Int.random(in: 0...2)
    @State private var playerScore = 0
    @State private var currentRound = 1
    @State private var showingFinalScore = false
    @State private var shouldWin = Bool.random()
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("Score: \(playerScore)").font(.system(size: 35)).padding().frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 25).bold()
                Spacer()
                Text(shouldWin ? "What beats..." : "What loses to ...").font(.largeTitle)
                Text(optionsIcons[gameOption]).font(.system(size: UIScreen.main.bounds.height/6)).padding(.top, 5).shadow(radius: 5)
                Spacer()
                HStack {
                    ForEach(0..<optionsIcons.count, id: \.self) { index in
                        Spacer()
                        Button {
                            moveSelected(buttonIcon: optionsIcons[index])
                        } label: {
                            ButtonOption(icon: optionsIcons[index], label: options[index])
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }.alert("End of game. You scored \(playerScore)/10.", isPresented: $showingFinalScore) {
            Button("Yes", action: resetGame)
        } message: {
            Text("Would you like to play again?")
        }
    }
    
    func moveSelected(buttonIcon: String) {
        let gameMove = optionsIcons[gameOption]
        let correctMove = shouldWin ? winningOptions[gameMove] : losingOptions[gameMove]
        playerScore += correctMove == buttonIcon ? 1 : 0
        
        if currentRound == 10 {
            showingFinalScore = true
        } else {
            generateNewRound()
        }
    }
    
    func generateNewRound() {
        currentRound += 1
        gameOption = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func resetGame() {
        currentRound = 1
        playerScore = 0
        shouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
