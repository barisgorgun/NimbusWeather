//
//  LoadFavoriteCitiesWeatherUseCase.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

public protocol LoadFavoriteCitiesWeatherUseCaseProtocol {
    func execute() async throws -> [FavoriteCityWeather]
}

public final class LoadFavoriteCitiesWeatherUseCase: LoadFavoriteCitiesWeatherUseCaseProtocol {
    private let repository: FavoriteCityRepositoryProtocol
    private let weatherService: WeatherRepositoryProtocol

    public init(repository: FavoriteCityRepositoryProtocol, weatherService: WeatherRepositoryProtocol) {
        self.repository = repository
        self.weatherService = weatherService
    }

    public func execute() async throws -> [FavoriteCityWeather] {
        let favorites = try await repository.getFavoriteCities()

        if favorites.isEmpty {
            return []
        }

        return try await withThrowingTaskGroup(of: FavoriteCityWeather?.self) { group in
            for city in favorites {
                group.addTask { [weatherService] in
                    do {
                        let weather = try await weatherService.getWeather(
                            lat: city.latitude,
                            lon: city.longitude
                        )
                        return FavoriteCityWeather(city: city, weather: weather)
                    } catch {
                        return nil
                    }
                }
            }

            var results: [FavoriteCityWeather] = []

            for try await item in group {
                if let item {
                    results.append(item)
                }
            }

            return results.sorted { $0.city.name < $1.city.name }
        }
    }
}
