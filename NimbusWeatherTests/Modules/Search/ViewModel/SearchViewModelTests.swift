//
//  SearchViewModelTests.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import XCTest
@testable import NimbusWeather
@testable import NimbusWeatherDomain

@MainActor
final class SearchViewModelTests: XCTestCase {
    private var useCase: MockSearchUseCase!
    private var viewModel: SearchViewModel!

    override func setUp() async throws {
        try await super.setUp()
        useCase = MockSearchUseCase()
        viewModel = SearchViewModel(searchUseCase: useCase)
    }

    override func tearDown() async throws {
        useCase = nil
        viewModel = nil
        try await super.tearDown()
    }

    func test_queryEmpty_clearsResults_andDoesNotCallUseCase() async throws {
        // Given
        useCase.jsonFileName = "search_locations_success"

        viewModel.query = "Lon"

        try? await Task.sleep(for: .milliseconds(500))

        XCTAssertFalse(viewModel.results.isEmpty, "Results should be loaded with initial query")

        // When
        viewModel.query = ""

        try? await Task.sleep(for: .milliseconds(100))

        // Then
        XCTAssertTrue(viewModel.results.isEmpty, "Results should be cleared when query becomes empty")
    }

    func test_queryTriggersSearch_afterDebounce() async throws {
        // Given
        useCase.jsonFileName = "search_locations_success"

        XCTAssertFalse(useCase.isExecuted)

        // When
        viewModel.query = "Lon"

        try? await Task.sleep(for: .milliseconds(500))

        // Then
        XCTAssertTrue(useCase.isExecuted, "UseCase should be executed after debounce")
        XCTAssertFalse(viewModel.results.isEmpty, "Results should be populated after search")
    }

    func test_search_setsLoadingStatesCorrectly() async throws {
        // Given
        useCase.jsonFileName = "search_locations_success"

        // When
        viewModel.query = "Lon"

        try? await Task.sleep(for: .milliseconds(800))

        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after search completes")
        XCTAssertFalse(viewModel.results.isEmpty, "Results should be populated after search completes")
    }


    func test_search_returnsUniqueCountries() async throws {
        // Given
        useCase.jsonFileName = "search_locations_success"

        // When
        viewModel.query = "Lon"

        try? await Task.sleep(for: .milliseconds(500))

        // Then
        XCTAssertEqual(viewModel.results.count, 2, "Should contain one entry per unique country")

        let countries = viewModel.results.map { $0.country }.sorted()

        XCTAssertEqual(countries, ["DE", "GB"], "ViewModel should reduce results to unique countries")
    }

    func test_search_mapsSearchErrors_toCorrectMessages() async throws {
        let cases: [(SearchError, String)] = [
            (.networkUnavailable, "No network connection"),
            (.invalidAPIKey,      "Invalid API key"),
            (.rateLimited,        "You are rate-limited"),
            (.noResults,          "No results found"),
            (.decodingFailed,     "Failed to decode response"),
            (.serverError(statusCode: 500),   "Server error: 500"),
            (.unknown,            "Unknown error")
        ]

        for (error, expectedMessage) in cases {

            // Given
            useCase.shouldThrow = true
            useCase.errorToThrow = error

            // When
            viewModel.query = "Lon"
            try? await Task.sleep(for: .milliseconds(600))

            // Then
            XCTAssertEqual(
                viewModel.errorMessage,
                expectedMessage,
                "Expected \(expectedMessage) but got \(viewModel.errorMessage ?? "nil")"
            )

            viewModel.errorMessage = nil
            useCase.shouldThrow = false
        }
    }

    func test_search_unknownError_setsGenericMessage() async throws {
        // Given
        useCase.shouldThrow = true
        useCase.errorToThrow = NSError(domain: "Test", code: 123)

        // When
        viewModel.query = "Lon"
        try? await Task.sleep(for: .milliseconds(600))

        // Then
        XCTAssertEqual(
            viewModel.errorMessage,
            "Unknown error",
            "ViewModel should map non-SearchError errors to generic 'Unknown error'"
        )
    }
}
