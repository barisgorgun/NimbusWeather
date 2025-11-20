//
//  GetWeatherUseCase.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public protocol GetWeatherUseCaseProtocol: Sendable {
    func execute(lat: Double, lon: Double) async throws -> Weather
}

public final class GetWeatherUseCase: GetWeatherUseCaseProtocol {
    private let weatherRepository: WeatherRepositoryProtocol

    public init(weatherRepository: WeatherRepositoryProtocol) {
        self.weatherRepository = weatherRepository
    }

    public func execute(lat: Double, lon: Double) async throws -> Weather {
        try await weatherRepository.getWeather(lat: lat, lon: lon)
    }
}
