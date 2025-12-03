//
//  LocationSearchResult.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public struct LocationSearchResult: Decodable, Sendable, Equatable {
    public let name: String
    public let country: String
    public let lat: Double
    public let lon: Double
    public let state: String?

    public init(
        name: String,
        country: String,
        lat: Double,
        lon: Double,
        state: String?
    ) {
        self.name = name
        self.country = country
        self.lat = lat
        self.lon = lon
        self.state = state
    }
}
