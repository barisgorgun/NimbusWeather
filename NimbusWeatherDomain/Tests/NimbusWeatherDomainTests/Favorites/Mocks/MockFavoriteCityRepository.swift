//
//  MockFavoriteCityRepository.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain

final class MockFavoriteCityRepository: FavoriteCityRepositoryProtocol, @unchecked Sendable {
    var storedCities: [FavoriteCity] = []
    var expectedError: Error?
    var removedIDs: [UUID] = []

    func getFavoriteCities() async throws -> [FavoriteCity] {
        if let error = expectedError {
            throw error
        }
        return storedCities
    }

    func addFavorite(_ city: FavoriteCity) async throws {
        if let error = expectedError {
            throw error
        }
        storedCities.append(city)
    }

    func removeFavorite(id: UUID) async throws {
        if let error = expectedError {
            throw error
        }
        removedIDs.append(id)
        storedCities.removeAll { $0.id == id }
    }
}
