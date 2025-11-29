//
//  FavoriteCity.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

public struct FavoriteCity: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public var name: String
    public var latitude: Double
    public var longitude: Double

    public init(
        id: UUID = UUID(),
        name: String,
        latitude: Double,
        longitude: Double,
    ) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
