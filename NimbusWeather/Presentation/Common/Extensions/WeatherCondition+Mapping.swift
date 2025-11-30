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
    case partlyCloudy
    case overcast
    case rainy
    case snow
    case thunder
    case fog
    case unknown
}

extension String {
    var toWeatherConditionType: WeatherConditionType {
        let c = self.lowercased()

        if c.contains("mist")
            || c.contains("fog")
            || c.contains("haze")
            || c.contains("smoke") {
            return .fog
        }

        if c.contains("thunder") {
            return .thunder
        }

        if c.contains("snow") {
            return .snow
        }

        if c.contains("rain")
            || c.contains("drizzle") {
            return .rainy
        }

        if c.contains("overcast") {
            return .overcast
        }

        if c.contains("broken")
            || c.contains("scattered")
            || c.contains("few clouds") {
            return .partlyCloudy
        }

        if c.contains("cloud") {
            return .cloudy
        }

        if c.contains("clear") || c.contains("sunny") {
            return .sunny
        }

        return .unknown
    }
}
