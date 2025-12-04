//
//  MockLocationPermissionManager.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
import CoreLocation
@testable import NimbusWeather

final class MockLocationPermissionManager: LocationPermissionManager {

    var mockStatus: CLAuthorizationStatus = .notDetermined
    var requestCalled = false

    override func checkStatus() -> CLAuthorizationStatus {
        return mockStatus
    }

    override func requestPermission() async -> CLAuthorizationStatus {
        requestCalled = true
        return mockStatus
    }
}
