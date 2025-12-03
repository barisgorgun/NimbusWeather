//
//  SearchLocationMapperTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherData
@testable import NimbusWeatherDomain

final class SearchLocationMapperTests: XCTestCase {

    func test_searchLocation_mapping_fromJSON() throws {
        // Given
        let dtoList =  try JSONLoader.load("search_locations", as: [SearchLocationDTO].self)

        // When
        let results = dtoList.map { SearchLocationMapper.map($0) }

        // Then
        XCTAssertEqual(results.count, dtoList.count)
        XCTAssertEqual(results[0].name, dtoList[0].name)
        XCTAssertEqual(results[0].country, dtoList[0].country)
        XCTAssertEqual(results[0].lat, dtoList[0].lat, accuracy: 0.0001)
        XCTAssertEqual(results[0].lon, dtoList[0].lon, accuracy: 0.0001)
        XCTAssertEqual(results[0].state, dtoList[0].state)
        XCTAssertEqual(results[1].name, dtoList[1].name)
        XCTAssertEqual(results[1].country, dtoList[1].country)
        XCTAssertEqual(results[1].lat, dtoList[1].lat, accuracy: 0.0001)
        XCTAssertEqual(results[1].lon, dtoList[1].lon, accuracy: 0.0001)
        XCTAssertEqual(results[1].state, dtoList[1].state)
    }
}
