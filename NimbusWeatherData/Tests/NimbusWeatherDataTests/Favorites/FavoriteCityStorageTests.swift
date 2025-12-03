//
//  FavoriteCityStorageTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeatherData
@testable import NimbusWeatherDomain

final class FavoriteCityStorageTests: XCTestCase {
    private var storage: FavoriteCityStorageProtocol!
    private var container: UserDefaultsContainer!

    override func setUp() async throws {
        try await super.setUp()
        let ud = makeTestUserDefaults()
        container = UserDefaultsContainer(ud)
        storage = FavoriteCityStorage(container: container)
    }

    override func tearDown() async throws {
        storage = nil
        container = nil
        try await super.tearDown()
    }

    func test_load_returnsEmptyList_whenNoSavedData() async {
        // When
        let favorites = await storage.load()

        // Then
        XCTAssertTrue(favorites.isEmpty)
    }

    func test_saveAndLoad_persistsFavorites() async {
        // Given
        let city = FavoriteCity(
            id: UUID(),
            name: "Istanbul",
            latitude: 41.0,
            longitude: 29.0
        )
        await storage.save([city])

        // When
        let favorites = await storage.load()

        // Then
        XCTAssertNotNil(favorites)
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.name, "Istanbul")
        XCTAssertEqual(favorites.first?.latitude, 41.0)
        XCTAssertEqual(favorites.first?.longitude, 29.0)
    }

    func test_save_overwritesPreviousValues() async {
        // Given
        let city1 = FavoriteCity(
            id: UUID(),
            name: "Istanbul",
            latitude: 41.0,
            longitude: 29.0
        )

        let city2 = FavoriteCity(
            id: UUID(),
            name: "Ankara",
            latitude: 39.9,
            longitude: 32.8
        )

        // When
        await storage.save([city1])
        await storage.save([city2])

        let loaded = await storage.load()

        // Then
        XCTAssertEqual(loaded.count, 1)
        XCTAssertEqual(loaded.first?.name, "Ankara")
    }

    private func makeTestUserDefaults() -> UserDefaults {
        let suiteName = "favorite_city_storage_tests_\(UUID().uuidString)"
        return UserDefaults(suiteName: suiteName)!
    }
}
