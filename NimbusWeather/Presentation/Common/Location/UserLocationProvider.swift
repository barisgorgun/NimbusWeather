//
//  UserLocationProvider.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Foundation
import CoreLocation


protocol UserLocationProviderProtocol {
    func getLocation() async throws -> CLLocationCoordinate2D
}

final class UserLocationProvider: NSObject, CLLocationManagerDelegate, UserLocationProviderProtocol {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Error>?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }

    func getLocation() async throws -> CLLocationCoordinate2D {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first?.coordinate {
            continuation?.resume(returning: loc)
        }
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
            manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }
}
