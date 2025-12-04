//
//  MockLoadFavoriteCitiesWeatherUseCase.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain

final class MockLoadFavoriteCitiesWeatherUseCase: LoadFavoriteCitiesWeatherUseCaseProtocol {
    var result: Result<[FavoriteCityWeather], Error> = .success([])

    func execute() async throws -> [FavoriteCityWeather] {
        try result.get()
    }
}
