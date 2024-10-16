//
//  MarcM_CoursSwiftApp.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 15/10/2024.
//

import SwiftUI

@main
struct MarcM_CoursSwiftApp: App {
    @StateObject private var appSettings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSettings)
        }
    }
}
