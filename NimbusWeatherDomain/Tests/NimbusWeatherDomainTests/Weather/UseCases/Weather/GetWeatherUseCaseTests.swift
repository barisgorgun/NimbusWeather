//
//  GetWeatherUseCaseTests.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import XCTest
@testable import NimbusWeatherDomain

final class GetWeatherUseCaseTests: XCTestCase {
    private var mockRepository: MockWeatherRepository!
    private var sut: GetWeatherUseCaseProtocol!

    override func setUp() async throws {
        try await super.setUp()
        mockRepository = MockWeatherRepository()
        sut = GetWeatherUseCase(weatherRepository: mockRepository)
    }

    override func tearDown() async throws {
        mockRepository = nil
        sut = nil
        try await super.tearDown()
    }

    func test_execute_returnsWeatherOnSuccess() async throws {
        // Given
        let mockWeather = Weather.sample(condition: "Clear")

        mockRepository.expectedWeather = mockWeather

        // When
        let result = try await sut.execute(lat: 0, lon: 0)

        // Then
        XCTAssertEqual(result.timezone, mockWeather.timezone)
        XCTAssertEqual(result.current.temperature, mockWeather.current.temperature)
        XCTAssertEqual(result.current.condition, mockWeather.current.condition)
    }

    func test_execute_throwsErrorOnRepositoryFailure() async throws {
        // Given
        mockRepository.expectedError = WeatherError.serverError(statusCode: 500)

        // When & Then
        do {
            _ = try await sut.execute(lat: 0, lon: 0)
            XCTFail("Expected to throw, but succeeded.")
        } catch {
            XCTAssertTrue(error is WeatherError, "Expected WeatherError but got \(error)")
        }
    }
}
