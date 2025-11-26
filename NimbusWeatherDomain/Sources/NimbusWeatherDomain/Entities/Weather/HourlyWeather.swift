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
    public let condition: WeatherCondition

    public init(
        date: Date,
        temperature: Double,
        condition: WeatherCondition
    ) {
        self.date = date
        self.temperature = temperature
        self.condition = condition
    }
}
