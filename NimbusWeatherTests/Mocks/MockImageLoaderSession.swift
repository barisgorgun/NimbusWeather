//
//  MockImageLoaderSession.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
@testable import NimbusWeather

final class MockImageLoaderSession: ImageLoadingSession {
    var dataToReturn: Data?
    var shouldThrow = false
    var loadCallCount = 0

    func load(from url: URL) async throws -> Data {
        loadCallCount += 1

        if shouldThrow { throw URLError(.badURL) }
        guard let data = dataToReturn else {
            throw URLError(.cannotLoadFromNetwork)
        }
        return data
    }
}
