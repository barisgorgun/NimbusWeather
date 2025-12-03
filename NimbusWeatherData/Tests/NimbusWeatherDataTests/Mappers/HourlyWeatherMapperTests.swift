//
//  HourlyWeatherMapperTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherData
@testable import NimbusWeatherDomain

final class HourlyWeatherMapperTests: XCTestCase {

    func test_hourlyWeather_mapping_fromJSON() throws {
        // Given
        let dto = try JSONLoader.load("hourly_weather", as: HourlyWeatherDTO.self)

        // When
        let model = try HourlyWeatherMapper.map(dto)

        // Then
        XCTAssertEqual(model.temperature, dto.temp, accuracy: 0.001)
        XCTAssertEqual(model.condition, dto.weather.first?.main)
        XCTAssertEqual(model.icon, dto.weather.first?.icon)
    }

    func test_hourlyWeather_noWeatherData_throwsError() throws {
        // Given
        let emptyDTO = HourlyWeatherDTO(
            dt: 1709456400,
            temp: 14.2,
            weather: []
        )

        // Then
        XCTAssertThrowsError(try HourlyWeatherMapper.map(emptyDTO)) { error in
            XCTAssertEqual(error as? WeatherError, WeatherError.noWeatherData)
        }
    }
}
