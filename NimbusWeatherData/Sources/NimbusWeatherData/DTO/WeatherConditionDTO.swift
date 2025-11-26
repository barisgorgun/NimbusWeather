//
//  WeatherConditionDTO.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import NimbusWeatherDomain
import Foundation

public struct WeatherConditionDTO: Decodable, Sendable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

extension WeatherConditionDTO {
    var iconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(self.icon)@4x.png")
    }
}
