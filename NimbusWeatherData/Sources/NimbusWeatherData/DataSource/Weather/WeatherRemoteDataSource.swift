//
//  WeatherRemoteDataSource.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public protocol WeatherRemoteDataSourceProtocol: Sendable {
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponseDTO
}
