//
//  MockAddFavoriteCityUseCase.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain

final class MockAddFavoriteCityUseCase: AddFavoriteCityUseCaseProtocol {
    var shouldThrow = false
    var executedCity: FavoriteCity?

    func execute(_ city: FavoriteCity) async throws {
        executedCity = city

        if shouldThrow {
            throw NSError(domain: "Test", code: -1)
        }
    }
}
