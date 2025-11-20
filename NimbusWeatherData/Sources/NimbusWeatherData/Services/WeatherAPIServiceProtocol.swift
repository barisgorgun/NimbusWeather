//
//  WeatherAPIServiceProtocol.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public protocol WeatherAPIServiceProtocol: Sendable {
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponseDTO
}
