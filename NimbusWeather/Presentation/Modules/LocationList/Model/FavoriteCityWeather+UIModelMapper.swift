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
        switch condition.lowercased() {
        case "clear":
            "sunny_bg"
        case "clouds":
            "cloudy_bg"
        case "rain":
            "rainy_bg"
        case "fog":
            "fog_bg"
        case "thunderstorm":
            "storm_bg"
        case "partly cloudy":
            "partly_cloudy_bg"
        case "overcast":
            "overcast_bg"
        default:
            "default_bg"
        }
    }
}
