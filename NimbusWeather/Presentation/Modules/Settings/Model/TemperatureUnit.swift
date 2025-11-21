//
//  TemperatureUnit.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Foundation

enum TemperatureUnit: String, CaseIterable {
    case celsius, fahrenheit

    var displayName: String {
        switch self {
        case .celsius:
            "Celsius (°C)"
        case .fahrenheit:
            "Fahrenheit (°F)"
        }
    }
}
