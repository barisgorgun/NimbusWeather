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
    let temperature: String
    let icon: String
}
