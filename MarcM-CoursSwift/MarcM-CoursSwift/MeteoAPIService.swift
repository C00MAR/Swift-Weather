//
//  MeteoAPIService.swift
//  MarcM-CoursSwift
//
//  Created by MOUREAU Marc on 16/10/2024.
//

import Foundation

class MeteoAPIService {
    private let apiKey = "c84ad59d1f9b99ac5066d8cf1e286ba293aed86b7eb899d9ccff7806e4a3e94e"
    private let baseURL = "https://api.meteo-concept.com/api/forecast/daily"
    
    func fetchWeather(forInsee insee: String) async throws -> (CityInfo, WeatherData) {
        let urlString = "\(baseURL)?token=\(apiKey)&insee=\(insee)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Code de statut HTTP: \(httpResponse.statusCode)")
        }
        
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        guard let todayForecast = weatherResponse.forecast.first else {
            throw NSError(domain: "MeteoAPIService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Aucune prévision disponible"])
        }
                
        return (weatherResponse.city, todayForecast)
    }
}

// Les structures WeatherResponse, CityInfo et WeatherData restent inchangées
struct WeatherResponse: Codable {
    let city: CityInfo
    let forecast: [WeatherData]
}

struct CityInfo: Codable {
    let insee: String
    let cp: Int
    let name: String
    let latitude: Float
    let longitude: Float
    let altitude: Int
}

struct WeatherData: Codable {
    let tmin: Int
    let tmax: Int
    let weather: Int
    
    var averageTemperature: Double {
        Double(tmin + tmax) / 2.0
    }
    
    var condition: String {
        switch weather {
        case 0: return "Soleil"
        case 1: return "Peu nuageux"
        case 2: return "Ciel voilé"
        case 3: return "Nuageux"
        case 4: return "Très nuageux"
        case 5: return "Couvert"
        case 6, 7: return "Brouillard"
        case 10, 11, 12, 13, 14, 15, 16: return "Pluie"
        case 20, 21, 22, 30, 31, 32: return "Neige"
        case 40, 41, 42, 43, 44, 45, 46, 47: return "Orages"
        default: return "Inconnu"
        }
    }
}
