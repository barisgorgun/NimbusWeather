//
//  FavoriteCityWeather+UIModelMapper.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation
import NimbusWeatherDomain

extension FavoriteCityWeather {
    var toUIModel: FavoriteCityUIModel {
        FavoriteCityUIModel(
            id: city.id,
            lat: city.latitude,
            lon: city.longitude,
            city: city.name,
            time: formattedTime(timezone: weather.timezone),
            condition: weather.current.condition,
            temperature: weather.current.temperature,
            high: weather.daily.first?.maxTemp ?? weather.current.temperature,
            low: weather.daily.first?.minTemp ?? weather.current.temperature,
            backgroundImage: backgroundForCondition(weather.current.condition)
        )
    }

    private func formattedTime(timezone: String) -> String {
        guard let tz = TimeZone(identifier: timezone) else {
            return Date().formatted(date: .omitted, time: .shortened)
        }

        let formatter = DateFormatter()
        formatter.timeZone = tz
        formatter.dateFormat = "HH:mm"

        return formatter.string(from: Date())
    }

    private func backgroundForCondition(_ condition: String) -> String {
        let c = condition.lowercased()

        if c.contains("mist") ||
           c.contains("fog") ||
           c.contains("haze") ||
           c.contains("smoke") {
            return "fog_bg"
        }

        if c.contains("thunder") {
            return "storm_bg"
        }

        if c.contains("rain") || c.contains("drizzle") {
            return "rainy_bg"
        }

        if c.contains("snow") {
            return "snow_bg"
        }

        if c.contains("overcast") {
            return "overcast_bg"
        }

        if c.contains("broken") ||
           c.contains("scattered") ||
           c.contains("few clouds") {
            return "partly_cloudy_bg"
        }

        if c.contains("cloud") {
            return "cloudy_bg"
        }

        if c.contains("clear") {
            return "sunny_bg"
        }

        return "default_bg"
    }
}
