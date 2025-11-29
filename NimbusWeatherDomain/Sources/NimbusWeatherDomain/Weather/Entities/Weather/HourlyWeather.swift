//
//  HourlyWeather.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct HourlyWeather: Sendable, Equatable {
    public let date: Date
    public let temperature: Double
    public let icon: String
    public let condition: String

    public init(
        date: Date,
        temperature: Double,
        icon: String,
        condition: String
    ) {
        self.date = date
        self.temperature = temperature
        self.icon = icon
        self.condition = condition
    }
}

public extension HourlyWeather {
    func formattedHour(in timezone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: timezone) ?? .current
        return formatter.string(from: date)
    }
}
