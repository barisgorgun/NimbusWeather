//
//  LocationService.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Foundation
import CoreLocation


protocol LocationServiceProtocol {
    func resolveCityName(lat: Double, lon: Double) async -> String?
}

final class LocationService: LocationServiceProtocol {
    private let geocoder = CLGeocoder()

    func resolveCityName(lat: Double, lon: Double) async -> String? {
        let location = CLLocation(latitude: lat, longitude: lon)

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)

            if let place = placemarks.first {
                return place.locality ?? place.administrativeArea
            }
        } catch {
            print("Geocoding error:", error)
        }
        return nil
    }
}
