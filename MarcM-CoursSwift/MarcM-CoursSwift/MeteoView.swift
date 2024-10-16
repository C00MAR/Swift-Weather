//
//  MeteoView.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 16/10/2024.
//

import SwiftUI

struct MeteoView: View {
    @State private var inseeCode: String = ""
    @State private var cityInfo: CityInfo?
    @State private var weatherData: WeatherData?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var debugInfo: String = ""
    @EnvironmentObject var appSettings: AppSettings
    
    private let apiService = MeteoAPIService()
    
    var body: some View {
        ZStack {
            appSettings.currentTheme.backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    Text("Météo par Code INSEE")
                        .font(.largeTitle)
                        .foregroundColor(appSettings.currentTheme.textColor)
                        .padding()
                    
                    HStack {
                        TextField("Entrez le code INSEE", text: $inseeCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .foregroundColor(appSettings.currentTheme.textColor)
                            .background(appSettings.currentTheme.backgroundColor)
                        
                        Button(action: {
                            if !inseeCode.isEmpty {
                                fetchWeather(insee: inseeCode)
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(appSettings.currentTheme.backgroundColor)
                                .padding(10)
                                .background(appSettings.currentTheme.accentColor)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: appSettings.currentTheme.textColor))
                    } else if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    } else if let city = cityInfo, let weather = weatherData {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Météo pour \(city.name)")
                                .font(.title2)
                            Text("Code INSEE: \(city.insee)")
                            Text("Code postal: \(city.cp)")
                            Text("Altitude: \(city.altitude) m")
                            Text("Latitude: \(city.latitude), Longitude: \(city.longitude)")
                            
                            Divider()
                            
                            Text("Température: \(Int(weather.averageTemperature))°C")
                            Text("Min: \(weather.tmin)°C, Max: \(weather.tmax)°C")
                            Text("Condition: \(weather.condition)")
                        }
                        .padding()
                        .background(appSettings.currentTheme.backgroundColor.opacity(0.1))
                        .cornerRadius(10)
                        .padding()
                    }
                    
                    if !debugInfo.isEmpty {
                        Text("Informations de débogage:")
                            .font(.headline)
                            .padding(.top)
                        Text(debugInfo)
                            .font(.footnote)
                            .padding()
                            .background(appSettings.currentTheme.backgroundColor.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
            }
        }
        .foregroundColor(appSettings.currentTheme.textColor)
        .navigationBarItems(trailing:
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(appSettings.currentTheme.textColor)
            }
        )
        .preferredColorScheme(appSettings.currentTheme == .shadow ? .dark : .light)
    }
    
    private func fetchWeather(insee: String) {
            isLoading = true
            errorMessage = nil
            debugInfo = ""
            
            Task {
                do {
                    let (city, weather) = try await apiService.fetchWeather(forInsee: insee)
                    DispatchQueue.main.async {
                        self.cityInfo = city
                        self.weatherData = weather
                        self.isLoading = false
                        self.debugInfo = "Données récupérées avec succès pour \(city.name)"
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Erreur: \(error.localizedDescription)"
                        self.isLoading = false
                        self.debugInfo = "Erreur lors de la récupération des données: \(error)"
                    }
                }
            }
        }
}

struct MeteoView_Previews: PreviewProvider {
    static var previews: some View {
        MeteoView()
            .environmentObject(AppSettings())
    }
}
