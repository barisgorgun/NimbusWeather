//
//  LocationSearchResult+Fixture.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain


extension LocationSearchResult {
    static var sample: LocationSearchResult {
        .init(name: "Istanbul", country: "TR", lat: 41.0, lon: 29.0, state: "Istanbul")
    }

    static var sample2: LocationSearchResult {
        .init(name: "Ankara", country: "TR", lat: 39.9, lon: 32.8, state: "Ankara")
    }
}
