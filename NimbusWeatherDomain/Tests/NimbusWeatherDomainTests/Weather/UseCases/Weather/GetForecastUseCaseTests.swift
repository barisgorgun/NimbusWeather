//
//  GetForecastUseCaseTests.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import XCTest
import NimbusWeatherDomain

final class GetForecastUseCaseTests: XCTestCase {
    private var repository: MockWeatherRepository!
    private var sut: GetForecastUseCaseProtocol!

    override func setUp() async throws {
        try await super.setUp()
        repository = MockWeatherRepository()
        sut = GetForecastUseCase(weatherRepository: repository)
    }

    override func tearDown() async throws {
        repository = nil
        sut = nil
        try await super.tearDown()
    }

    func test_execute_returnsDailyForecastOnSuccess() async throws {
        // Given
        let sampleWeather = Weather(
            timezone: "Europe/Istanbul",
            current: CurrentWeather(
                date: Date(),
                temperature: 20,
                feelsLike: 18,
                humidity: 50,
                windSpeed: 3.5,
                pressure: 1015,
                sunrise: Date(),
                sunset: Date(),
                condition: "Clear",
                icon: "01d"
            ),
            hourly: [],
            daily: getMockDailyForecasts()
        )

        repository.expectedWeather = sampleWeather

        // When
        let result = try await sut.execute(lat: 0, lon: 0)

        // Then
        XCTAssertEqual(result.count, 5)
    }

    func test_execute_throwsErrorOnRepositoryFailure() async throws {
        // Given
        repository.expectedError = WeatherError.serverError(statusCode: 500)

        // When & Then
        do {
            _ = try await sut.execute(lat: 0, lon: 0)
            XCTFail("Expected to throw, but succeeded.")
        } catch {
            XCTAssertTrue(error is WeatherError, "Expected WeatherError but got \(error)")
        }
    }

    private func getMockDailyForecasts() -> [DailyWeather] {
        let mockDailyList: [DailyWeather] = [
            DailyWeather(
                date: Date(timeIntervalSince1970: 1_700_000_000),
                minTemp: 12.0,
                maxTemp: 22.0,
                icon: "01d",
                condition: "Clear"
            ),
            DailyWeather(
                date: Date(timeIntervalSince1970: 1_700_086_400),
                minTemp: 13.0,
                maxTemp: 21.0,
                icon: "02d",
                condition: "Partly Cloudy"
            ),
            DailyWeather(
                date: Date(timeIntervalSince1970: 1_700_172_800),
                minTemp: 10.0,
                maxTemp: 19.0,
                icon: "04d",
                condition: "Cloudy"
            ),
            DailyWeather(
                date: Date(timeIntervalSince1970: 1_700_259_200),
                minTemp: 14.0,
                maxTemp: 20.0,
                icon: "10d",
                condition: "Rain"
            ),
            DailyWeather(
                date: Date(timeIntervalSince1970: 1_700_345_600),
                minTemp: 8.0,
                maxTemp: 17.0,
                icon: "13d",
                condition: "Snow"
            )
        ]

        return mockDailyList
    }
}
