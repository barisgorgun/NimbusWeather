//
//  WeatherCondition+Mapping.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 22.11.2025.
//

import Foundation

enum WeatherConditionType {
    case sunny
    case cloudy
    case rainy
    case snow
    case thunder
    case fog
    case unknown
}

extension String {
    var toWeatherConditionType: WeatherConditionType {
        let lower = self.lowercased()

        if lower.contains("sun") || lower.contains("clear") {
            return .sunny
        }
        if lower.contains("cloud") {
            return .cloudy
        }
        if lower.contains("rain") {
            return .rainy
        }
        if lower.contains("snow") {
            return .snow
        }
        if lower.contains("thunder") {
            return .thunder
        }
        if lower.contains("fog") {
            return .fog
        }
        return .unknown
    }
}
