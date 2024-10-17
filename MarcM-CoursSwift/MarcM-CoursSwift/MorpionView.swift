//
//  MorpionView.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 16/10/2024.
//

import SwiftUI

struct MorpionView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var gameOver = false
    @State private var winMessage = ""
    @State private var scoreX = 0
    @State private var scoreO = 0
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        ZStack {
            appSettings.currentTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Jeu de Morpion")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(appSettings.currentTheme.textColor)
                
                HStack {
                    ScoreView(player: "X", score: scoreX)
                    Spacer()
                    ScoreView(player: "O", score: scoreO)
                }
                .padding(.horizontal)
                
                Text(gameOver ? winMessage : "Au tour de : \(currentPlayer)")
                    .font(.title2)
                    .foregroundColor(appSettings.currentTheme.textColor)
                    .padding()
                
                GameBoardView(board: $board, currentPlayer: $currentPlayer, gameOver: $gameOver, checkWinner: checkWinner)
                    .padding()
                
                VStack(spacing: 20) {
                    ActionButton(title: "Recommencer", action: resetGame)
                    ActionButton(title: "Réinitialiser les scores", action: resetScores)
                }
            }
            .padding()
        }
        .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(appSettings.currentTheme.textColor)
        })
        .navigationTitle("Retour")
        .preferredColorScheme(appSettings.currentTheme == .shadow ? .dark : .light)
    }
    
    private func checkWinner() {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        for pattern in winPatterns {
            if pattern.allSatisfy({ board[$0] == currentPlayer }) {
                gameOver = true
                winMessage = "Le joueur \(currentPlayer) a gagné !"
                updateScore()
                return
            }
        }
        
        if !board.contains("") {
            gameOver = true
            winMessage = "Match nul !"
        }
    }
    
    private func updateScore() {
        if currentPlayer == "X" {
            scoreX += 1
        } else {
            scoreO += 1
        }
    }
    
    private func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        gameOver = false
        winMessage = ""
    }
    
    private func resetScores() {
        scoreX = 0
        scoreO = 0
        resetGame()
    }
}

struct GameBoardView: View {
    @Binding var board: [String]
    @Binding var currentPlayer: String
    @Binding var gameOver: Bool
    let checkWinner: () -> Void
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<3) { row in
                HStack(spacing: 5) {
                    ForEach(0..<3) { col in
                        let index = row * 3 + col
                        Button(action: {
                            if board[index].isEmpty && !gameOver {
                                board[index] = currentPlayer
                                checkWinner()
                                if !gameOver {
                                    currentPlayer = currentPlayer == "X" ? "O" : "X"
                                }
                            }
                        }) {
                            Text(board[index])
                                .font(.system(size: 40, weight: .bold))
                                .frame(width: 80, height: 80)
                                .foregroundColor(appSettings.currentTheme.textColor)
                                .background(appSettings.currentTheme.backgroundColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(appSettings.currentTheme.textColor, lineWidth: 2)
                                )
                        }
                    }
                }
            }
        }
        .cornerRadius(10)
    }
}

struct ScoreView: View {
    let player: String
    let score: Int
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        VStack {
            Text("Joueur \(player)")
                .font(.headline)
            Text("\(score)")
                .font(.title)
                .fontWeight(.bold)
        }
        .padding()
        .background(appSettings.currentTheme.accentColor.opacity(0.2))
        .cornerRadius(10)
        .foregroundColor(appSettings.currentTheme.textColor)
    }
}

struct ActionButton: View {
    let title: String
    let action: () -> Void
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(appSettings.currentTheme.accentColor)
                .foregroundColor(appSettings.currentTheme.backgroundColor)
                .cornerRadius(10)
        }
    }
}

struct MorpionView_Previews: PreviewProvider {
    static var previews: some View {
        MorpionView()
            .environmentObject(AppSettings())
    }
}
