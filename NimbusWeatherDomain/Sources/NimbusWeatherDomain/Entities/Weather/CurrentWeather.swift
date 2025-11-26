//
//  CurrentWeather.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct CurrentWeather: Sendable, Equatable {
    public let date: Date
    public let temperature: Double
    public let feelsLike: Double
    public let humidity: Int
    public let windSpeed: Double
    public let pressure: Int
    public let sunrise: Date
    public let sunset: Date
    public let condition: String
    public let icon: String

    public init(
        date: Date,
        temperature: Double,
        feelsLike: Double,
        humidity: Int,
        windSpeed: Double,
        pressure: Int,
        sunrise: Date,
        sunset: Date,
        condition: String,
        icon: String
    ) {
        self.date = date
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.pressure = pressure
        self.sunrise = sunrise
        self.sunset = sunset
        self.condition = condition
        self.icon = icon
    }
}
