//
//  CurrentWeatherUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

struct CurrentWeatherUIModel: Equatable {
    let temperature: Double
    let condition: String
    let feelsLikeValue: Double
    let high: Double
    let low: Double
    let icon: String
    let humidity: String
    let windSpeed: String
    let pressure: String

    var iconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@4x.png")
    }
}
