//
//  CurrentWeatherDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct CurrentWeatherDTO: Decodable, Sendable {
    public let dt: Double
    public let temp: Double
    public let feelsLike: Double
    public let humidity: Int
    public let windSpeed: Double
    public let pressure: Int
    public let sunrise: Double
    public let sunset: Double
    public let weather: [WeatherConditionDTO]
}
