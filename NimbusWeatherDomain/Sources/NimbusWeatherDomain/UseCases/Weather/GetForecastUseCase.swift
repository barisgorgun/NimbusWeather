//
//  GetForecastUseCase.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public protocol GetForecastUseCaseProtocol: Sendable {
    func execute(lat: Double, lon: Double) async throws -> [DailyWeather]
}

public final class GetForecastUseCase: GetForecastUseCaseProtocol {
    private let weatherRepository: WeatherRepositoryProtocol

    public init(weatherRepository: WeatherRepositoryProtocol) {
        self.weatherRepository = weatherRepository
    }

    public func execute(lat: Double, lon: Double) async throws -> [DailyWeather] {
        let weather = try await weatherRepository.getWeather(lat: lat, lon: lon)
        return weather.daily
    }
}
