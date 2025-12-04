//
//  MockUserLocationProvider.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
import CoreLocation
@testable import NimbusWeather

final class MockUserLocationProvider: UserLocationProviderProtocol {
    var shouldThrow = false
    var errorToThrow: Error = NSError(domain: "Test", code: -1)
    var mockLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    func getLocation() async throws -> CLLocationCoordinate2D {
        if shouldThrow {
            throw errorToThrow
        }
        return mockLocation
    }
}
