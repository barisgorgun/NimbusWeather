//
//  MockWeatherRepository.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import Foundation
import NimbusWeatherDomain

final class MockWeatherRepository: WeatherRepositoryProtocol, @unchecked Sendable {
    var expectedWeather: Weather?
    var expectedError: Error?

    var results: [String: Result<Weather, Error>] = [:]

    func getWeather(lat: Double, lon: Double) async throws -> Weather {

        let key = "\(lat)-\(lon)"
        if let mapped = results[key] {
            switch mapped {
            case .success(let w):
                return w
            case .failure(let e):
                throw e
            }
        }

        if let error = expectedError {
            throw error
        }

        if let weather = expectedWeather {
            return weather
        }

        fatalError("""
        MockWeatherRepository has no mock for:
        lat: \(lat), lon: \(lon).
        → Provide expectedWeather/expectedError OR results["lat-lon"].
        """)
    }
}
