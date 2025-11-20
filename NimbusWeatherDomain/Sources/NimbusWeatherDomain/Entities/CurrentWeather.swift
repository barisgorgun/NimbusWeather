//
//  CurrentWeather.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct CurrentWeather: Sendable, Equatable {
    public let temperature: Double
    public let feelsLike: Double
    public let humidity: Int
    public let windSpeed: Double
    public let pressure: Int
    public let condition: String
    public let icon: String
    public let date: Date
    public let sunrise: Date
    public let sunset: Date

    public init(
        temperature: Double,
        feelsLike: Double,
        humidity: Int,
        windSpeed: Double,
        pressure: Int,
        condition: String,
        icon: String,
        date: Date,
        sunrise: Date,
        sunset: Date
    ) {
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.pressure = pressure
        self.condition = condition
        self.icon = icon
        self.date = date
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
