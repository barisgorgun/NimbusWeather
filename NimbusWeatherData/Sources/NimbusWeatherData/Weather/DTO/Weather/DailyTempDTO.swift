//
//  DailyTempDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct DailyTempDTO: Decodable, Sendable {
    public let min: Double
    public let max: Double
}
