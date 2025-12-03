//
//  MockAPIService.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import Foundation
@testable import NimbusWeatherData

final class MockAPIService: APIServiceProtocol, @unchecked Sendable {
    private let jsonLoader = JSONLoader.self
    var lastEndpoint: (any Endpoint)?

    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "MockAPIService", code: -1)
    var forceJSONFileName: String?

    func request<T: Decodable>(_ endpoint: any Endpoint) async throws -> T {
        lastEndpoint = endpoint

        if shouldThrowError {
            throw errorToThrow
        }

        let fileName = jsonFileName(for: endpoint)
        return try jsonLoader.load(fileName, as: T.self)
    }

    private func jsonFileName(for endpoint: any Endpoint) -> String {
        if let forced = forceJSONFileName {
            return forced
        }

        switch endpoint {
        case is SearchEndpoint:
            return "search_locations"
        case is WeatherEndpoint:
            return "weather_response"
        default:
            fatalError("JSON mapping is not defined for this endpoint: \(endpoint)")
        }
    }
}
