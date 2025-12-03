//
//  SearchRepositoryTests.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeatherData
@testable import NimbusWeatherDomain

final class SearchRepositoryTests: XCTestCase {
    private var dataSource: MockSearchRemoteDataSource!
    private var repository: LocationSearchRepositoryProtocol!

    override func setUp() async throws {
        try await super.setUp()
        dataSource = MockSearchRemoteDataSource()
        repository = SearchRepositoryImpl(remote: dataSource)
    }

    override func tearDown() async throws {
        dataSource = nil
        repository = nil
        try await super.tearDown()
    }

    func test_search_returnsMappedDomainModels_onSuccess() async throws {
        // Given
        dataSource.forceJSONFileName = "search_locations"

        // When
        let result = try await repository.search(query: "Istanbul")

        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Istanbul")
        XCTAssertEqual(result.first?.country, "TR")
    }

    func test_search_passesQueryToRemoteDataSource() async throws {
        // Given
        dataSource.forceJSONFileName = "search_locations"

        // When
        _ = try await repository.search(query: "Istanbul")

        // Then
        XCTAssertEqual(dataSource.lastQuery, "Istanbul")
    }

    func test_search_mapsAPIError_toSearchError() async {
        let mappingCases: [(APIError, SearchError)] = [
            (.invalidURL, .networkUnavailable),
            (.requestFailed, .networkUnavailable),
            (.unauthorized, .invalidAPIKey),
            (.notFound, .noResults),
            (.serverError, .serverError(statusCode: 500)),
            (.decodingError, .decodingFailed),
            (.invalidResponse, .decodingFailed),
            (.unknown, .unknown)
        ]

        for (apiError, expectedSearchError) in mappingCases {

            // Given
            let mockRemote = MockSearchRemoteDataSource()
            mockRemote.shouldThrowError = true
            mockRemote.errorToThrow = apiError

            let repository = SearchRepositoryImpl(remote: mockRemote)

            // When / Then
            do {
                _ = try await repository.search(query: "Berlin")
                XCTFail("Expected SearchError but got success")
            } catch {
                XCTAssertEqual(error as? SearchError, expectedSearchError)
            }
        }
    }

    func test_search_returnsUnknownError_forNonAPIError() async {
        // Given
        dataSource.shouldThrowError = true
        dataSource.errorToThrow = NSError(domain: "Test", code: 123)

        // When / Then
        do {
            _ = try await repository.search(query: "Paris")
            XCTFail("Expected SearchError.unknown but got success")
        } catch {
            XCTAssertEqual(error as? SearchError, .unknown)
        }
    }

}
