//
//  MainAppView.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 15/10/2024.
//

import SwiftUI

struct MenuAppView: View {
    @EnvironmentObject var appSettings: AppSettings
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                appSettings.currentTheme.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Menu Principal")
                        .font(.largeTitle)
                        .foregroundColor(appSettings.currentTheme.textColor)
                        .padding()
                    
                    NavigationLink(destination: MeteoView()) {
                        Text("Application Météo")
                            .padding()
                            .background(appSettings.currentTheme.accentColor)
                            .foregroundColor(appSettings.currentTheme.backgroundColor)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: MorpionView()) {
                        Text("Jeu de Morpion")
                            .padding()
                            .background(appSettings.currentTheme.accentColor)
                            .foregroundColor(appSettings.currentTheme.backgroundColor)
                            .cornerRadius(10)
                    }
                    
                    Button("Déconnexion") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationBarTitle("Menu Principal")
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(appSettings.currentTheme.textColor)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(appSettings.currentTheme == .shadow ? .dark : .light)
    }
}

struct MenuAppView_Previews: PreviewProvider {
    static var previews: some View {
        MenuAppView()
            .environmentObject(AppSettings())
    }
}
