//
//  Weather.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct Weather: Sendable, Equatable {
    public let current: CurrentWeather
    public let hourly: [HourlyWeather]
    public let daily: [DailyWeather]

    public init(
        current: CurrentWeather,
        hourly: [HourlyWeather],
        daily: [DailyWeather]
    ) {
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
}
