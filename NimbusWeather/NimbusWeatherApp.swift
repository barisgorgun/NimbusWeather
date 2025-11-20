//
//  NimbusWeatherApp.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import SwiftUI

@main
struct NimbusWeatherApp: App {
    private let diContainer: DIContainer = DIContainer.shared

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: diContainer.makeHomeViewModel())
        }
    }
}
