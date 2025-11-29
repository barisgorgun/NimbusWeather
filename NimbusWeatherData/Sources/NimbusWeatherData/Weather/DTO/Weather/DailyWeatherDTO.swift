//
//  DailyWeatherDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct DailyWeatherDTO: Decodable, Sendable {
    public let dt: Double
    public let temp: DailyTempDTO
    public let weather: [WeatherConditionDTO]
}
