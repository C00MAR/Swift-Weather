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
        NavigationView {
            ZStack {
                appSettings.currentTheme.backgroundColor.edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        line
                        Text("connexion")
                            .fontWeight(.bold)
                            .textCase(.uppercase)
                        line
                    }
                    VStack(spacing: 10) {
                        TextField("Username", text: $username)
                            .padding(15.0)
                            .border(appSettings.currentTheme.textColor)
                            .cornerRadius(3)
                        SecureField("Mot De Passe", text: $password)
                            .padding(15.0)
                            .border(appSettings.currentTheme.textColor)
                            .cornerRadius(3)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 25)

                    if let error = error {
                        Text(error)
                            .foregroundColor(.red)
                            .padding(.bottom, 25)
                            .padding(.top, -20)
                    }
                    HStack {
                        line
                        Button(action: {
                            logUser()
                        }) {
                            Text("Se connecter")
                                .fontWeight(.bold)
                                .textCase(.uppercase)
                                .padding(20)
                                .frame(width: 175.0, height: 50.0)
                                .background(appSettings.currentTheme.accentColor)
                                .foregroundColor(appSettings.currentTheme.backgroundColor)
                                .cornerRadius(5)
                        }
                        line
                    }
                }
            }
            .navigationTitle("Connexion")
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(appSettings.currentTheme.textColor)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $isConnected) {
            MenuAppView()
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
    
    var line: some View {
        VStack {
            Divider().background(appSettings.currentTheme.textColor)
        }
        .padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppSettings())
    }
}
