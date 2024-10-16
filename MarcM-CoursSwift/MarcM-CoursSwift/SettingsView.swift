//
//  SettingsView.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 16/10/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        NavigationView {
            ZStack {
                appSettings.currentTheme.backgroundColor.edgesIgnoringSafeArea(.all)
                
                Form {
                    Section(header: Text("Thème de couleurs").foregroundColor(appSettings.currentTheme.textColor)) {
                        ForEach(AppSettings.ColorTheme.allCases, id: \.self) { theme in
                            Button(action: {
                                appSettings.currentTheme = theme
                            }) {
                                HStack {
                                    Text(theme.name)
                                    Spacer()
                                    if appSettings.currentTheme == theme {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(appSettings.currentTheme.accentColor)
                                    }
                                }
                            }
                            .foregroundColor(appSettings.currentTheme.textColor)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Réglages")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(appSettings.currentTheme.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .accentColor(appSettings.currentTheme.accentColor)
        .preferredColorScheme(appSettings.currentTheme == .shadow ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppSettings())
    }
}
