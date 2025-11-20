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
    public let feels_like: Double
    public let humidity: Int
    public let wind_speed: Double
    public let pressure: Int
    public let weather: [WeatherConditionDTO]
}
