//
//  MockFavoriteCityStorage.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

@testable import NimbusWeatherData
@testable import NimbusWeatherDomain

final class MockFavoriteCityStorage: FavoriteCityStorageProtocol {

    var storedCities: [FavoriteCity] = []
    var loadCallCount = 0
    var saveCallCount = 0
    var lastSaved: [FavoriteCity] = []

    func load() async -> [FavoriteCity] {
        loadCallCount += 1
        return storedCities
    }

    func save(_ favorites: [FavoriteCity]) async {
        saveCallCount += 1
        lastSaved = favorites
        storedCities = favorites
    }
}
