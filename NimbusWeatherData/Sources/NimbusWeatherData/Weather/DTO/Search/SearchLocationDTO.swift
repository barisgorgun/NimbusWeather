//
//  SearchLocationDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public struct SearchLocationDTO: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?

    public init(
        name: String,
        lat: Double,
        lon: Double,
        country: String,
        state: String?
    ) {
        self.name = name
        self.lat = lat
        self.lon = lon
        self.country = country
        self.state = state
    }
}
