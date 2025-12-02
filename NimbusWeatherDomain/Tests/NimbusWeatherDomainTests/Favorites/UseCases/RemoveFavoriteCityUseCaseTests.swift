//
//  RemoveFavoriteCityUseCaseTests.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain

final class RemoveFavoriteCityUseCaseTests: XCTestCase {
    private var mockRepository: MockFavoriteCityRepository!
    private var sut: RemoveFavoriteCityUseCaseProtocol!

    override func setUp() async throws {
        try await super.setUp()
        mockRepository = MockFavoriteCityRepository()
        sut = RemoveFavoriteCityUseCase(repository: mockRepository)
    }

    override func tearDown() async throws {
        mockRepository = nil
        sut = nil
        try await super.tearDown()
    }

    func test_execute_removesCitySuccessfully() async throws {
        // Given
        let city = FavoriteCity(
            name: "Berlin",
            latitude: 52.5,
            longitude: 13.4
        )
        mockRepository.storedCities = [city]

        // When
        try await sut.execute(city.id)

        // Then
        XCTAssertTrue(mockRepository.removedIDs.contains(city.id))
        XCTAssertTrue(mockRepository.storedCities.isEmpty)
    }

    func test_execute_throwsErrorWhenRepositoryFails() async {
        // Given
        let failingCityID = UUID()
        mockRepository.expectedError = NSError(domain: "test", code: -1)

        // When & Then
        do {
            try await sut.execute(failingCityID)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
