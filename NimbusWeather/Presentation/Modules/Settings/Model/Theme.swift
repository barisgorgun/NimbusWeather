//
//  Theme.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Foundation

enum Theme: String, CaseIterable {
    case system, light, dark

    var displayName: String {
        switch self {
        case .system:
            "System"
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }
}
