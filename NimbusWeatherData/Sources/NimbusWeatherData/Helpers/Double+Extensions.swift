//
//  File.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

extension Double {
    var asDate: Date {
        Date(timeIntervalSince1970: self)
    }
}
