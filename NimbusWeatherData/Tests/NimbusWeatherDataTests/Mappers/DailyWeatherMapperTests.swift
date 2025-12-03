//
//  DailyWeatherMapperTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherData
@testable import NimbusWeatherDomain

final class DailyWeatherMapperTests: XCTestCase {

    func test_dailyWeather_mapping_fromJSON() throws {
        // Given
        let dto = try JSONLoader.load("daily_weather", as: DailyWeatherDTO.self)

        // When
        let model = try DailyWeatherMapper.map(dto)

        // Then
        XCTAssertEqual(model.minTemp, dto.temp.min, accuracy: 0.001)
        XCTAssertEqual(model.maxTemp, dto.temp.max, accuracy: 0.001)

        XCTAssertEqual(model.condition, dto.weather.first?.main)
        XCTAssertEqual(model.icon, dto.weather.first?.icon)

        XCTAssertEqual(
            model.date.timeIntervalSince1970,
            dto.dt,
            accuracy: 0.1
        )
    }

    func test_dailyWeather_noWeatherData_throwsError() throws {
        // Given
        let temp = DailyTempDTO(min: 8.5, max: 17.3)
        let emptyDTO = DailyWeatherDTO(
            dt: 1709500000,
            temp: temp,
            weather: []
        )

        // Then
        XCTAssertThrowsError(try DailyWeatherMapper.map(emptyDTO)) { error in
            XCTAssertEqual(error as? WeatherError, WeatherError.noWeatherData)
        }
    }
}
