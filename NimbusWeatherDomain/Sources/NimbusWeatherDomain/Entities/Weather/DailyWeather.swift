//
//  DailyWeather.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct DailyWeather: Sendable, Equatable {
    public let date: Date
    public let minTemp: Double
    public let maxTemp: Double
    public let icon: String
    public let condition: String

    public init(
        date: Date,
        minTemp: Double,
        maxTemp: Double,
        icon: String,
        condition: String
    ) {
        self.date = date
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.icon = icon
        self.condition = condition
    }
}
