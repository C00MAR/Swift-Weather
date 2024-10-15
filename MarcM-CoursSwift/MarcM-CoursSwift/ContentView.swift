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

    
    private let rootUser = "Root"
    private let rootPassword = "root"

    var body: some View {
        NavigationStack {
            VStack {
                Text("Connection :")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .padding()
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Mot De Passe", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
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
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                .padding()
                
                NavigationLink(destination: MenuAppView(), isActive: $isConnected) {
                    EmptyView()
                }
            }
        }
    }
    
    private func logUser() {
        if username == rootUser && password == rootPassword{
            isConnected = true
            error = nil
        } else if username == "" {
            error = "Veuillez remplir le nom d'utilisateur"
        } else if password == "" {
            error = "Veuillez remplir le mot de passe"
        } else {
            error = "Nom d'utilisateur ou MDP incorect"
        }
    }
}

#Preview {
    ContentView()
}
