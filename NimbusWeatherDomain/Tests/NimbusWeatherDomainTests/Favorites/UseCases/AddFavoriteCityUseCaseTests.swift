//
//  AddFavoriteCityUseCaseTests.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain

final class AddFavoriteCityUseCaseTests: XCTestCase {
    private var mockRepository: MockFavoriteCityRepository!
    private var sut: AddFavoriteCityUseCaseProtocol!

    override func setUp() async throws {
        try await super.setUp()

        mockRepository = MockFavoriteCityRepository()
        sut = AddFavoriteCityUseCase(repository: mockRepository)
    }

    override func tearDown() async throws {
        mockRepository = nil
        sut = nil
        try await super.tearDown()
    }

    func test_execute_addsCityToRepository() async throws {
        // Given
        let city = FavoriteCity(
            name: "Istanbul",
            latitude: 41.0,
            longitude: 29.0
        )

        // When
        try await sut.execute(city)

        // Then
        let favorites = try await mockRepository.getFavoriteCities()
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites.first?.name, "Istanbul")
        XCTAssertEqual(favorites.first?.latitude, 41.0)
        XCTAssertEqual(favorites.first?.longitude, 29.0)
    }

    func test_execute_throwsErrorWhenRepositoryFails() async {
        // Given
        let city = FavoriteCity(
            name: "Ankara",
            latitude: 39.9,
            longitude: 32.8
        )

        mockRepository.expectedError = NSError(domain: "test", code: 1)

        // When & Then
        do {
            _ = try await sut.execute(city)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
