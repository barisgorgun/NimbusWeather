//
//  HourlyWeatherUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

struct HourlyWeatherUIModel: Identifiable, Equatable {
    let id = UUID()
    let hour: String
    let temperature: Double
    let icon: String
    
    var iconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@4x.png")
    }
}
