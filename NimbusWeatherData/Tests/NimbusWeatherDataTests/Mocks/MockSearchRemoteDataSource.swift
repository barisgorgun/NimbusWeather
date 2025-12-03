//
//  MockSearchRemoteDataSource.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain
@testable import NimbusWeatherData

final class MockSearchRemoteDataSource: SearchRemoteDataSourceProtocol, @unchecked Sendable {
    private(set) var lastQuery: String?

    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "MockSearchRemote", code: -1)
    var forceJSONFileName: String?

    func search(query: String) async throws -> [SearchLocationDTO] {
        lastQuery = query

        if shouldThrowError {
            throw errorToThrow
        }

        let fileName = forceJSONFileName ?? "search_locations"
        return try JSONLoader.load(fileName, as: [SearchLocationDTO].self)
    }
}
