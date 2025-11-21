//
//  WeatherBackgroundStyleMapper.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

enum WeatherBackgroundStyleMapper {

    static func map(
        condition: String,
        isNight: Bool
    ) -> WeatherBackgroundStyle {

        let lower = condition.lowercased()

        if isNight {
            if lower.contains("cloud") {
                return .nightClouds
            } else {
                return .nightClear
            }
        }

        if lower.contains("clear") {
            return .clear
        } else if lower.contains("cloud") {
            return .clouds
        } else if lower.contains("rain") || lower.contains("drizzle") {
            return .rain
        } else if lower.contains("thunder") {
            return .thunderstorm
        } else if lower.contains("snow") {
            return .snow
        } else if lower.contains("mist")
               || lower.contains("fog")
               || lower.contains("haze") {
            return .fog
        }

        return .clouds
    }
}

