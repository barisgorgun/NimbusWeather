//
//  MockLocationService.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
@testable import NimbusWeather

final class MockLocationService: LocationServiceProtocol {
    var resolvedCityName: String? = nil

    func resolveCityName(lat: Double, lon: Double) async -> String? {
        resolvedCityName
    }
}
