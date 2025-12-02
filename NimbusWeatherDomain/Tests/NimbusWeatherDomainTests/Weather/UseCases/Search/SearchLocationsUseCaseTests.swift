//
//  SearchLocationsUseCaseTests.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import XCTest
@testable import NimbusWeatherDomain

final class SearchLocationsUseCaseTests: XCTestCase {

    private var mockRepository: MockLocationSearchRepository!
    private var sut: SearchLocationsUseCaseProtocol!

    override func setUp() async throws {
        try await super.setUp()

        mockRepository = MockLocationSearchRepository()
        sut = SearchLocationsUseCase(
            searchRepository: mockRepository
        )
    }
    
    override func tearDown() async throws {
        mockRepository = nil
        sut = nil
        try await super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_execute_returnsResults_onSuccess() async throws {
        // GIVEN
        mockRepository.expectedResults = [
            .sample,
            .sample2
        ]
        
        // WHEN
        let results = try await sut.execute(
            query: "ist"
        )
        
        // THEN
        XCTAssertEqual(
            results.count,
            2
        )
        XCTAssertEqual(
            results.first?.name,
            "Istanbul"
        )
        XCTAssertEqual(
            results.last?.lat,
            39.9
        )
    }
    
    func test_execute_throwsError_onRepositoryFailure() async {
        // GIVEN
        mockRepository.expectedError = NSError(
            domain: "Test",
            code: 1
        )
        
        // WHEN / THEN
        do {
            _ = try await sut.execute(
                query: "ist"
            )
            XCTFail(
                "Expected error but got success."
            )
        } catch {
            XCTAssertNotNil(
                error
            )
        }
    }
    
    func test_execute_returnsEmptyArray_whenRepositoryReturnsEmpty() async throws {
        // GIVEN
        mockRepository.expectedResults = []
        
        // WHEN
        let results = try await sut.execute(
            query: "abc"
        )
        
        // THEN
        XCTAssertTrue(
            results.isEmpty
        )
    }
}
