//
//  MockWeatherUseCase.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain
@testable import NimbusWeatherData

final class MockWeatherUseCase: GetWeatherUseCaseProtocol {
    var jsonFileName: String?
    var shouldThrow = false
    var errorToThrow: Error = NSError(domain: "Test", code: -1)

    private(set) var receivedLat: Double?
    private(set) var receivedLon: Double?

    func execute(lat: Double, lon: Double) async throws -> Weather {
        receivedLat = lat
        receivedLon = lon

        if shouldThrow { throw errorToThrow }

        guard let file = jsonFileName else {
            fatalError("jsonFileName must be set")
        }

        let dto = try JSONLoader.load(file, as: WeatherResponseDTO.self)

        return try WeatherMapper.map(dto)
    }
}
