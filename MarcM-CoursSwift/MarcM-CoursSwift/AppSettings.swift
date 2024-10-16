//
//  AppSettings.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 16/10/2024.
//

import SwiftUI

class AppSettings: ObservableObject {
    enum ColorTheme: String, CaseIterable {
        case terracotta, cloud, forest, shadow
        
        var backgroundColor: Color {
            switch self {
            case .terracotta: return Color(red: 0.98, green: 0.36, blue: 0.23) // Couleur terracotta de l'image
            case .cloud: return Color(red: 0.88, green: 0.87, blue: 0.83) // Couleur gris clair de l'image
            case .forest: return Color(red: 0.17, green: 0.50, blue: 0.25) // Couleur verte de l'image
            case .shadow: return Color.black // Noir pour le thème sombre
            }
        }
        
        var textColor: Color {
            switch self {
            case .terracotta, .forest: return .black
            case .cloud: return .black
            case .shadow: return .white
            }
        }
        
        var accentColor: Color {
            switch self {
            case .terracotta: return Color.black
            case .cloud: return Color.black
            case .forest: return Color.black
            case .shadow: return Color.white
            }
        }
        
        var name: String {
            rawValue.capitalized
        }
    }
    
    @Published var currentTheme: ColorTheme = .cloud
}
