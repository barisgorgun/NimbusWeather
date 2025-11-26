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
            "Celsius (\(displaySembol))"
        case .fahrenheit:
            "Fahrenheit (\(displaySembol))"
        }
    }

    var displaySembol: String {
        switch self {
        case .celsius:
            "°C"
        case .fahrenheit:
            "°F"
        }
    }

    func convert(_ value: Double) -> Double {
        switch self {
        case .celsius:
            value
        case .fahrenheit:
            (value * 9/5) + 32
        }
    }
}
