//
//  MockLocationSearchRepository.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import Foundation
@testable import NimbusWeatherDomain

final class MockLocationSearchRepository: LocationSearchRepositoryProtocol, @unchecked Sendable {
    var expectedResults: [LocationSearchResult] = []
    var expectedError: Error?

    func search(query: String) async throws -> [LocationSearchResult] {
        if let error = expectedError {
            throw error
        }
        return expectedResults
    }
}
