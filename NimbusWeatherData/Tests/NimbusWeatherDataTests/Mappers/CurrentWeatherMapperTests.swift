//
//  CurrentWeatherMapperTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherData

final class CurrentWeatherMapperTests: XCTestCase {

    func test_currentWeather_mapping_fromJSON() throws {
       // Given
        let dto = try JSONLoader.load("current_weather", as: CurrentWeatherDTO.self)

        // When
        let model = try CurrentWeatherMapper.map(dto)

        // Then
        XCTAssertEqual(model.temperature, dto.temp, accuracy: 0.001)
        XCTAssertEqual(model.feelsLike, dto.feelsLike, accuracy: 0.001)
        XCTAssertEqual(model.humidity, dto.humidity)
        XCTAssertEqual(model.windSpeed, dto.windSpeed, accuracy: 0.001)
        XCTAssertEqual(model.condition, dto.weather.first?.main)
    }
}
