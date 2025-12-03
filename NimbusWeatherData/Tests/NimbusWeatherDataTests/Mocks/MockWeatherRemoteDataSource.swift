//
//  MockWeatherRemoteDataSource.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain
@testable import NimbusWeatherData

final class MockWeatherRemoteDataSource: WeatherRemoteDataSourceProtocol, @unchecked Sendable {
    var shouldThrowError = false
    var errorToThrow: Error = NSError(domain: "MockWeatherRemote", code: -1)
    var forceJSONFileName: String?

    private(set) var lastLat: Double?
    private(set) var lastLon: Double?

    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponseDTO {
        lastLat = lat
        lastLon = lon

        if shouldThrowError {
            throw errorToThrow
        }

        let fileName = forceJSONFileName ?? "weather_response"

        return try JSONLoader.load(fileName, as: WeatherResponseDTO.self)
    }
}
