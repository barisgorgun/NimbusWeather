//
//  DailyWeatherUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

struct DailyWeatherUIModel: Identifiable {
    let id = UUID()
    let day: String
    let minTemp: String
    let maxTemp: String
    let icon: String
}
