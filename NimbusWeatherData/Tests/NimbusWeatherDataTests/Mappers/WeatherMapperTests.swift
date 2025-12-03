//
//  WeatherMapperTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain
@testable import NimbusWeatherData

final class WeatherMapperTests: XCTestCase {

    func test_weatherMapper_mapping_fromJSON() throws {
        // Given
        let dto = try JSONLoader.load("weather_response", as: WeatherResponseDTO.self)

        // When
        let model = try WeatherMapper.map(dto)

        // Then
        XCTAssertEqual(model.timezone, dto.timezone)
        XCTAssertEqual(model.hourly.count, dto.hourly.count)
        XCTAssertEqual(model.daily.count, dto.daily.count)
        XCTAssertEqual(model.current.temperature, dto.current.temp, accuracy: 0.001)
        XCTAssertEqual(model.current.feelsLike, dto.current.feelsLike, accuracy: 0.001)
        XCTAssertEqual(model.current.humidity, dto.current.humidity)
        XCTAssertEqual(model.current.windSpeed, dto.current.windSpeed, accuracy: 0.001)
        XCTAssertEqual(model.current.condition, dto.current.weather.first?.main)
        XCTAssertEqual(model.current.icon, dto.current.weather.first?.icon)

        guard let firstHourlyDTO = dto.hourly.first,
              let firstHourly = model.hourly.first
        else {
            XCTFail("Hourly data should not be empty")
            return
        }

        XCTAssertEqual(firstHourly.temperature, firstHourlyDTO.temp, accuracy: 0.001)
        XCTAssertEqual(firstHourly.condition, firstHourlyDTO.weather.first?.main)
        XCTAssertEqual(firstHourly.icon, firstHourlyDTO.weather.first?.icon)

        guard let firstDailyDTO = dto.daily.first,
              let firstDaily = model.daily.first
        else {
            XCTFail("Daily data should not be empty")
            return
        }

        XCTAssertEqual(firstDaily.minTemp, firstDailyDTO.temp.min, accuracy: 0.001)
        XCTAssertEqual(firstDaily.maxTemp, firstDailyDTO.temp.max, accuracy: 0.001)
        XCTAssertEqual(firstDaily.condition, firstDailyDTO.weather.first?.main)
        XCTAssertEqual(firstDaily.icon, firstDailyDTO.weather.first?.icon)
    }
}
