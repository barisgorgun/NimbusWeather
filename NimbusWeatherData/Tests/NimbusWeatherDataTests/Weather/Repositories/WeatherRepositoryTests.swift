//
//  WeatherRepositoryTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain
@testable import NimbusWeatherData

final class WeatherRepositoryTests: XCTestCase {
    private var dataSource: MockWeatherRemoteDataSource!
    private var repository: WeatherRepositoryProtocol!

    override func setUp() async throws {
        try await super.setUp()
        dataSource = MockWeatherRemoteDataSource()
        repository = WeatherRepository(remote: dataSource)
    }

    override func tearDown() async throws {
        dataSource = nil
        repository = nil
        try await super.tearDown()
    }

    func test_getWeather_returnsMappedModel_onSuccess() async throws {
        // Given
        dataSource.forceJSONFileName = "weather_response"

        // When
        let result = try await repository.getWeather(lat: 41.0, lon: 29.0)

        // Then
        XCTAssertEqual(result.timezone, "Europe/Istanbul")
        XCTAssertNotNil(result.current)
        XCTAssertFalse(result.hourly.isEmpty)
        XCTAssertFalse(result.daily.isEmpty)
    }

    func test_getWeather_callsRemoteDataSource_withCorrectCoordinates() async throws {
        // Given
        dataSource.forceJSONFileName = "weather_response"

        // When
        _ = try await repository.getWeather(lat: 10.123, lon: 20.456)

        // Then
        XCTAssertEqual(dataSource.lastLat, 10.123)
        XCTAssertEqual(dataSource.lastLon, 20.456)
    }

    func test_getWeather_mapsAPIError_toWeatherError() async {
        let mappingCases: [(APIError, WeatherError)] = [
            (.invalidURL, .networkUnavailable),
            (.requestFailed, .networkUnavailable),
            (.unauthorized, .invalidAPIKey),
            (.notFound, .noWeatherData),
            (.serverError, .serverError(statusCode: 500)),
            (.decodingError, .decodingFailed),
            (.invalidResponse, .decodingFailed),
            (.unknown, .unknown)
        ]

        for (apiError, expectedWeatherError) in mappingCases {

            // Given
            let mockRemote = MockWeatherRemoteDataSource()
            mockRemote.shouldThrowError = true
            mockRemote.errorToThrow = apiError
            let repository = WeatherRepository(remote: mockRemote)

            // When / Then
            do {
                _ = try await repository.getWeather(lat: 0, lon: 0)
                XCTFail("Expected WeatherError but got success")
            } catch {
                XCTAssertEqual(error as? WeatherError, expectedWeatherError)
            }
        }
    }

    func test_getWeather_returnsUnknownError_forNonAPIError() async {
        // Given
        dataSource.shouldThrowError = true
        dataSource.errorToThrow = NSError(domain: "Test", code: 999)

        // When / Then
        do {
            _ = try await repository.getWeather(lat: 0, lon: 0)
            XCTFail("Expected WeatherError.unknown but got success")
        } catch {
            XCTAssertEqual(error as? WeatherError, .unknown)
        }
    }

}
