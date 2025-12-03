//
//  WeatherRemoteDataSourceImpl.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public final class WeatherRemoteDataSourceImpl: WeatherRemoteDataSourceProtocol {
    private let apiService: APIServiceProtocol
    private let apiKey: String

    public init(apiService: APIServiceProtocol, apiKey: String) {
        self.apiService = apiService
        self.apiKey = apiKey
    }

    public func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponseDTO {
        let endpoint = WeatherEndpoint(lat: lat, lon: lon, apiKey: apiKey)
        return try await apiService.request(endpoint)
    }
}
