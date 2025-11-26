//
//  WeatherCondition.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public enum WeatherCondition: String, Sendable, Equatable {
    case clear
    case clouds
    case rain
    case drizzle
    case snow
    case thunderstorm
    case fog
    case mist
    case haze
    case smoke
    case dust
    case sand
    case ash
    case squall
    case tornado
    case unknown

    public static func from(apiMain: String, description: String) -> WeatherCondition {
        let mainLower = apiMain.lowercased()
        let descLower = description.lowercased()

        if mainLower.contains("clear") {
            return .clear
        }

        if mainLower.contains("cloud") {
            return .clouds
        }

        if mainLower.contains("rain") {
            return .rain
        }

        if mainLower.contains("drizzle") {
            return .drizzle
        }

        if mainLower.contains("snow") {
            return .snow
        }

        if mainLower.contains("thunder") {
            return .thunderstorm
        }

        if mainLower.contains("mist") {
            return .mist
        }

        if mainLower.contains("fog") {
            return .fog
        }

        if mainLower.contains("haze") {
            return .haze
        }

        if mainLower.contains("smoke") {
            return .smoke
        }

        if mainLower.contains("dust") {
            return .dust
        }

        if mainLower.contains("sand") {
            return .sand
        }

        if mainLower.contains("ash") {
            return .ash
        }

        if mainLower.contains("squall") {
            return .squall
        }

        if mainLower.contains("tornado") {
            return .tornado
        }

        if descLower.contains("storm") {
            return .thunderstorm
        }

        if descLower.contains("rain") {
            return .rain
        }

        if descLower.contains("snow") {
            return .snow
        }

        if descLower.contains("clear") {
            return .clear
        }

        if descLower.contains("cloud") {
            return .clouds
        }

        return .unknown
    }
}

