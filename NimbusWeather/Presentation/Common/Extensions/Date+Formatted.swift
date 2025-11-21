//
//  Date+Formatted.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Foundation

extension Date {
    var formattedDateTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, HH:mm" // Tuesday, 14:20
        return formatter.string(from: self)
    }
}
