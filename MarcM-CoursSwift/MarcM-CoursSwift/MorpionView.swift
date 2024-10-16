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
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        ZStack {
            appSettings.currentTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Jeu de Morpion")
                    .font(.largeTitle)
                    .foregroundColor(appSettings.currentTheme.textColor)
                    .padding()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                    ForEach(0..<9) { index in
                        Button(action: {
                            if board[index].isEmpty {
                                board[index] = currentPlayer
                                currentPlayer = currentPlayer == "X" ? "O" : "X"
                            }
                        }) {
                            Text(board[index])
                                .font(.system(size: 40))
                                .frame(width: 80, height: 80)
                                .foregroundColor(appSettings.currentTheme.textColor)
                                .background(appSettings.currentTheme.backgroundColor.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                
                Button("Recommencer") {
                    board = Array(repeating: "", count: 9)
                    currentPlayer = "X"
                }
                .padding()
                .background(appSettings.currentTheme.accentColor)
                .foregroundColor(appSettings.currentTheme.backgroundColor)
                .cornerRadius(10)
            }
        }
        .navigationBarItems(trailing:
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(appSettings.currentTheme.textColor)
            }
        )
        .preferredColorScheme(appSettings.currentTheme == .shadow ? .dark : .light)
    }
}

struct MorpionView_Previews: PreviewProvider {
    static var previews: some View {
        MorpionView()
            .environmentObject(AppSettings())
    }
}
