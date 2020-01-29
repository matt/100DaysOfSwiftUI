//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matthew Mohrman on 12/1/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var computerSelection = Int.random(in: 0 ... 2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var numberOfPlays = 0 {
        didSet {
            gameEnded = numberOfPlays == 10
        }
    }
    @State private var gameEnded = false
    
    private let moves = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Score: \(score)")
                .font(.largeTitle)
            Text("The computer has chosen: \(moves[computerSelection])")
            Text("Attempt to: \(shouldWin ? "Win" : "Lose")")
            
            HStack {
                ForEach(0 ..< moves.count) { index in
                    Button(action: {
                        self.scorePlay(humanSelection: index)
                        self.setupNewPlay()
                    }) {
                        Text(self.moves[index])
                    }
                }
            }
            
            Spacer()
        }
        .alert(isPresented: $gameEnded) { () -> Alert in
            Alert(title: Text("Game Over"), message: Text("Final score: \(score)"), dismissButton: .default(Text("Play Again"), action: {
                self.startNewGame()
            }))
        }
    }
    
    func scorePlay(humanSelection: Int) {
        let offset = shouldWin ? 1 : -1
        let isVictorious = (computerSelection + offset - humanSelection) % moves.count == 0
        
        score += isVictorious ? 1 : -1
    }
    
    func setupNewPlay() {
        computerSelection = Int.random(in: 0 ... 2)
        shouldWin = Bool.random()
        numberOfPlays += 1
    }
    
    func startNewGame() {
        score = 0
        numberOfPlays = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
