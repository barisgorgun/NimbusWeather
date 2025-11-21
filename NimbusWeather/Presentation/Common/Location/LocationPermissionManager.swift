//
//  LocationPermissionManager.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import CoreLocation

final class LocationPermissionManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLAuthorizationStatus, Never>?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestPermission() async -> CLAuthorizationStatus {
        let current = manager.authorizationStatus

        if current != .notDetermined {
            return current
        }

        return await withCheckedContinuation { continuation in
            self.continuation = continuation
            manager.requestWhenInUseAuthorization()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if let continuation {
            continuation.resume(returning: manager.authorizationStatus)
            self.continuation = nil
        }
    }
}
