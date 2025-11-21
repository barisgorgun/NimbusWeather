//
//  AppThemeManager.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Combine
import Foundation
import SwiftUI

final class AppThemeManager: ObservableObject {
    @Published var selectedTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: "app_theme")
        }
    }

    init() {
        let saved = UserDefaults.standard.string(forKey: "app_theme")
        self.selectedTheme = AppTheme(rawValue: saved ?? "") ?? .system
    }

    var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .system:
            nil
        case .light:
            .light
        case .dark:
            .dark
        }
    }
}
