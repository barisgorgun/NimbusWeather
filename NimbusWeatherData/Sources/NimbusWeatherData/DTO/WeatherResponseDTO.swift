//
//  WeatherResponseDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct WeatherResponseDTO: Decodable, Sendable {
    public let lat: Double
    public let lon: Double
    public let timezone: String
    public let current: CurrentWeatherDTO
    public let hourly: [HourlyWeatherDTO]
    public let daily: [DailyWeatherDTO]
}
