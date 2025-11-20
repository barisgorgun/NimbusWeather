//
//  WeatherAPIServiceImpl.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public final class WeatherAPIServiceImpl: WeatherAPIServiceProtocol {
    private let apiService: APIService
    private let apiKey: String

    public init(apiService: APIService, apiKey: String) {
        self.apiService = apiService
        self.apiKey = apiKey
    }

    public func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponseDTO {
        let endpoint = WeatherEndpoint.fetchWeather(lat: lat, lon: lon, apiKey: apiKey)
        return try await apiService.request(endpoint)
    }
}
