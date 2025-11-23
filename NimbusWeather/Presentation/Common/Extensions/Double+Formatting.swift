//
//  Double+Formatting.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 23.11.2025.
//

import Foundation

extension Double {
    
    func formattedTemperature(unit: TemperatureUnit) -> String {
        let converted = unit.convert(self)
        return "\(Int(converted.rounded())) \(unit.displaySembol)"
    }
}
