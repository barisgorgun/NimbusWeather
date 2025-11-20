//
//  WeatherConditionDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct WeatherConditionDTO: Decodable, Sendable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}
