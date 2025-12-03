//
//  SearchRemoteDataSourceTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeatherData
@testable import NimbusWeatherDomain

final class SearchRemoteDataSourceTests: XCTestCase {
    private var mockAPIService: MockAPIService!
    private var dataSource: SearchRemoteDataSourceProtocol!

    override func setUp() async throws {
        try await super.setUp()
        mockAPIService = MockAPIService()
        dataSource = SearchRemoteDataSourceImpl(apiService: mockAPIService, apiKey: "TEST_KEY")
    }

    override func tearDown() async throws {
        mockAPIService = nil
        dataSource = nil
        try await super.tearDown()
    }

    func test_search_returnsParsedDTOList_onSuccess() async throws {
        // When
        let result = try await dataSource.search(query: "Istanbul")

         // Then
         XCTAssertEqual(result.count, 2)
         XCTAssertEqual(result[0].name, "Istanbul")
         XCTAssertEqual(result[1].name, "Ankara")

         let endpoint = mockAPIService.lastEndpoint as? SearchEndpoint
         XCTAssertNotNil(endpoint)
         XCTAssertEqual(endpoint?.cityName, "Istanbul")

    }

    func test_search_buildsCorrectEndpoint() async throws {
        // When
        _ = try await dataSource.search(query: "Istanbul")

        // Then
        guard let endpoint = mockAPIService.lastEndpoint as? SearchEndpoint else {
            return XCTFail("Expected endpoint to be SearchEndpoint")
        }

        XCTAssertEqual(endpoint.path, "/geo/1.0/direct")
        XCTAssertEqual(endpoint.baseURL, "https://api.openweathermap.org")
        XCTAssertEqual(endpoint.method, .get)

        let items = endpoint.queryItems

        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items.first { $0.name == "q" }?.value, "Istanbul")
        XCTAssertEqual(items.first { $0.name == "appid" }?.value, "TEST_KEY")
        XCTAssertEqual(items.first { $0.name == "limit" }?.value, "5")
    }

    func test_search_returnsEmptyArray_whenResponseIsEmpty() async throws {
        mockAPIService.forceJSONFileName = "search_locations_empty"

        // When
        let result = try await dataSource.search(query: "UnknownCity")

        // Then
        XCTAssertTrue(result.isEmpty)

        guard let endpoint = mockAPIService.lastEndpoint as? SearchEndpoint else {
            return XCTFail("Expected SearchEndpoint")
        }

        XCTAssertEqual(endpoint.cityName, "UnknownCity")
    }

    func test_search_throwsError_onAPIFailure() async throws {
        // Given
        mockAPIService.shouldThrowError = true
        mockAPIService.errorToThrow = NSError(domain: "Test", code: 999)

        do {
            // When
            _ = try await dataSource.search(query: "Berlin")
            XCTFail("Expected error but got success")
        } catch {
            // Then
            let nsError = error as NSError
            XCTAssertEqual(nsError.domain, "Test")
            XCTAssertEqual(nsError.code, 999)
        }

        let endpoint = mockAPIService.lastEndpoint as? SearchEndpoint
        XCTAssertNotNil(endpoint)
        XCTAssertEqual(endpoint?.cityName, "Berlin")
    }

    func test_search_includesApiKeyInEndpoint() async throws {
        // When
        _ = try await dataSource.search(query: "London")

        // Then
        guard let endpoint = mockAPIService.lastEndpoint as? SearchEndpoint else {
            return XCTFail("Expected SearchEndpoint")
        }

        let items = endpoint.queryItems

        let appIdItem = items.first { $0.name == "appid" }

        XCTAssertNotNil(appIdItem)
        XCTAssertEqual(appIdItem?.value, "TEST_KEY")
    }
}
