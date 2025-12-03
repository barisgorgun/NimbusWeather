//
//  WeatherRemoteDataSourceTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain
@testable import NimbusWeatherData

final class WeatherRemoteDataSourceTests: XCTestCase {
    private var mockAPIService: MockAPIService!
    private var dataSource: WeatherRemoteDataSourceProtocol!

    override func setUp() async throws {
        try await super.setUp()
        mockAPIService = MockAPIService()
        dataSource = WeatherRemoteDataSourceImpl(apiService: mockAPIService, apiKey: "TEST_KEY")
    }

    override func tearDown() async throws {
        mockAPIService = nil
        dataSource = nil
        try await super.tearDown()
    }

    func test_fetchWeather_returnsParsedDTO_onSuccess() async throws {
        // When
        let result = try await dataSource.fetchWeather(lat: 41.0, lon: 29.0)

        // Then
        XCTAssertEqual(result.timezone, "Europe/Istanbul")
        XCTAssertNotNil(result.current)
        XCTAssertFalse(result.hourly.isEmpty)
        XCTAssertFalse(result.daily.isEmpty)

        guard let endpoint = mockAPIService.lastEndpoint as? WeatherEndpoint else {
            return XCTFail("Expected WeatherEndpoint")
        }

        XCTAssertEqual(endpoint.lat, 41.0)
        XCTAssertEqual(endpoint.lon, 29.0)
    }

    func test_fetchWeather_buildsCorrectEndpoint() async throws {
        // When
        _ = try await dataSource.fetchWeather(lat: 41.0, lon: 29.0)

        // Then
        guard let endpoint = mockAPIService.lastEndpoint as? WeatherEndpoint else {
            return XCTFail("Expected WeatherEndpoint")
        }

        XCTAssertEqual(endpoint.baseURL, "https://api.openweathermap.org")
        XCTAssertEqual(endpoint.path, "/data/3.0/onecall")
        XCTAssertEqual(endpoint.method, .get)

        let items = endpoint.queryItems

        XCTAssertEqual(items.count, 5)
        XCTAssertEqual(items.first { $0.name == "lat" }?.value, "41.0")
        XCTAssertEqual(items.first { $0.name == "lon" }?.value, "29.0")
        XCTAssertEqual(items.first { $0.name == "appid" }?.value, "TEST_KEY")
        XCTAssertEqual(items.first { $0.name == "units" }?.value, "metric")
        XCTAssertEqual(items.first { $0.name == "exclude" }?.value, "minutely")
    }

    func test_fetchWeather_throwsError_onAPIFailure() async throws {
        // Given
        mockAPIService.shouldThrowError = true
        mockAPIService.errorToThrow = NSError(domain: "TestError", code: 123)

        do {
            // When
            _ = try await dataSource.fetchWeather(lat: 40.0, lon: 30.0)
            XCTFail("Expected error but got success")
        } catch {
            // Then
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "TestError")
            XCTAssertEqual(nsError.code, 123)
        }

        guard let endpoint = mockAPIService.lastEndpoint as? WeatherEndpoint else {
            return XCTFail("Expected WeatherEndpoint")
        }

        XCTAssertEqual(endpoint.lat, 40.0)
        XCTAssertEqual(endpoint.lon, 30.0)
    }
}
