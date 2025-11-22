//
//  AppThemeManager.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class AppThemeManager: ObservableObject {
    @AppStorage("theme") private var savedTheme: AppTheme = .system
    @Published var currentTheme: AppTheme = .system

    init() {
        currentTheme = savedTheme
    }

    func updateTheme(_ theme: AppTheme) {
        currentTheme = theme
        savedTheme = theme
    }
}
