//
//  ContentView.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 15/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isConnected: Bool = false
    @State private var error: String?
    @EnvironmentObject var appSettings: AppSettings
    
    private let rootUser = "Root"
    private let rootPassword = "root"

    var body: some View {
        NavigationStack {
            ZStack {
                appSettings.currentTheme.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Connection :")
                        .font(.largeTitle)
                        .foregroundColor(appSettings.currentTheme.textColor)
                        .padding()
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .foregroundColor(appSettings.currentTheme.textColor)
                        .background(appSettings.currentTheme.backgroundColor)
                    SecureField("Mot De Passe", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .foregroundColor(appSettings.currentTheme.textColor)
                        .background(appSettings.currentTheme.backgroundColor)
                    
                    if let error = error {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button(action: {
                        logUser()
                    }) {
                        Text("Connexion")
                            .padding()
                            .background(appSettings.currentTheme.accentColor)
                            .foregroundColor(appSettings.currentTheme.backgroundColor)
                            .cornerRadius(5)
                    }
                    .padding()
                    
                    .navigationDestination(isPresented: $isConnected) {
                        MenuAppView()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(appSettings.currentTheme.textColor)
                    }
                }
            }
        }
        .preferredColorScheme(appSettings.currentTheme == .shadow ? .dark : .light)
    }
    
    private func logUser() {
        if username == rootUser && password == rootPassword {
            isConnected = true
            error = nil
        } else if username.isEmpty {
            error = "Veuillez remplir le nom d'utilisateur"
        } else if password.isEmpty {
            error = "Veuillez remplir le mot de passe"
        } else {
            error = "Nom d'utilisateur ou MDP incorrect"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppSettings())
    }
}
