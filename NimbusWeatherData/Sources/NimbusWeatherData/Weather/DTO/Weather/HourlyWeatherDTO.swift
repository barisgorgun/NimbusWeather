//
//  HourlyWeatherDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct HourlyWeatherDTO: Decodable, Sendable {
    public let dt: Double
    public let temp: Double
    public let weather: [WeatherConditionDTO]
}
