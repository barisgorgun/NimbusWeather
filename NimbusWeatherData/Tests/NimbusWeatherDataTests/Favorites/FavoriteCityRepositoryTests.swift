//
//  FavoriteCityRepositoryTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain
@testable import NimbusWeatherData

final class FavoriteCityRepositoryTests: XCTestCase {
    private var mockStorage: MockFavoriteCityStorage!
    private var repository: FavoriteCityRepositoryProtocol!

    override func setUp() async throws {
        try await super.setUp()
        mockStorage = MockFavoriteCityStorage()
        repository = FavoriteCityRepositoryImpl(storage: mockStorage)
    }

    override func tearDown() async throws {
        mockStorage = nil
        repository = nil
        try await super.tearDown()
    }

    func test_getFavoriteCities_returnsStoredCities() async throws {
        // Given
        let city = FavoriteCity(id: UUID(), name: "Istanbul", latitude: 41, longitude: 29)
        await mockStorage.save([city])

        // When
        let result = try await repository.getFavoriteCities()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Istanbul")
        XCTAssertEqual(result.first?.latitude, 41)
        XCTAssertEqual(result.first?.longitude, 29)
        XCTAssertEqual(mockStorage.loadCallCount, 1)
    }

    func test_addFavorite_appendsNewCity() async throws {
        // Given
        let city = FavoriteCity(id: UUID(), name: "Istanbul", latitude: 41, longitude: 29)

        // When
        try await repository.addFavorite(city)

        // Then
        XCTAssertEqual(mockStorage.saveCallCount, 1)
        XCTAssertEqual(mockStorage.lastSaved.count, 1)
        XCTAssertEqual(mockStorage.lastSaved.first?.name, "Istanbul")
    }

    func test_addFavorite_doesNotAddDuplicateCity() async throws {
        // Given
        let city = FavoriteCity(id: UUID(), name: "Istanbul", latitude: 41, longitude: 29)
        mockStorage.storedCities = [city]

        // When
        try await repository.addFavorite(city)

        // Then
        XCTAssertEqual(mockStorage.saveCallCount, 0)
        XCTAssertEqual(mockStorage.storedCities.count, 1)
    }

    func test_removeFavorite_removesCityById() async throws {
        // Given
        let city1 = FavoriteCity(id: UUID(), name: "Istanbul", latitude: 41, longitude: 29)
        let city2 = FavoriteCity(id: UUID(), name: "Ankara", latitude: 39.9, longitude: 32.8)

        mockStorage.storedCities = [city1, city2]

        // When
        try await repository.removeFavorite(id: city1.id)

        // Then
        XCTAssertEqual(mockStorage.saveCallCount, 1)
        XCTAssertEqual(mockStorage.lastSaved.count, 1)
        XCTAssertEqual(mockStorage.lastSaved.first?.name, "Ankara")
    }
}
