//
//  LoadFavoriteCitiesWeatherUseCaseTests.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain

final class LoadFavoriteCitiesWeatherUseCaseTests: XCTestCase {
    private var mockRepository: MockFavoriteCityRepository!
    private var mockWeatherService: MockWeatherRepository!
    private var sut: LoadFavoriteCitiesWeatherUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockFavoriteCityRepository()
        mockWeatherService = MockWeatherRepository()
        sut = LoadFavoriteCitiesWeatherUseCase(
            repository: mockRepository,
            weatherService: mockWeatherService
        )
    }

    override func tearDown() {
        mockRepository = nil
        mockWeatherService = nil
        sut = nil
        super.tearDown()
    }

    func test_execute_returnsEmptyArray_whenNoFavorites() async throws {
        // Given
        mockRepository.storedCities = []

        // When
        let result = try await sut.execute()

        // Then
        XCTAssertTrue(result.isEmpty)
    }
    
    func test_execute_throwsError_whenRepositoryFails() async {
        // Given
        mockRepository.expectedError = NSError(domain: "test", code: 1)

        // When & Then
        do {
            try await sut.execute()
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func test_execute_returnsMappedWeatherForFavorites() async throws {
        // Given
        let city1 = FavoriteCity(name: "Berlin", latitude: 1, longitude: 1)
        let city2 = FavoriteCity(name: "Paris", latitude: 2, longitude: 2)

        mockRepository.storedCities = [city1, city2]

        mockWeatherService.expectedWeather = .sample(condition: "Clear")

        // When
        let result = try await sut.execute()

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].weather.current.condition, "Clear")
    }

    func test_execute_sortsResultsAlphabetically() async throws {
        // Given
        let c1 = FavoriteCity(name: "Zurich", latitude: 1, longitude: 1)
        let c2 = FavoriteCity(name: "Amsterdam", latitude: 2, longitude: 2)

        mockRepository.storedCities = [c1, c2]
        mockWeatherService.expectedWeather = .sample(condition: "Clear")

        // When
        let result = try await sut.execute()

        // Then
        XCTAssertEqual(result.map(\.city.name), ["Amsterdam", "Zurich"])
    }

    func test_execute_skipsCitiesThatFail() async throws {
        // Given
        let berlin = FavoriteCity(name: "Berlin", latitude: 1, longitude: 1)
        let rome = FavoriteCity(name: "Rome", latitude: 2, longitude: 2)

        mockRepository.storedCities = [berlin, rome]

        mockWeatherService.results = [
            "1.0-1.0": .success(.sample(condition: "Clear")),
            "2.0-2.0": .failure(WeatherError.unknown)
        ]

        // When
        let result = try await sut.execute()

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.city.name, "Berlin")
    }
}
