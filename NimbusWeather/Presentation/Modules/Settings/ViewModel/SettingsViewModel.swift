//
//  SettingsViewModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import Combine
import CoreLocation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @AppStorage("theme") var theme: Theme = .system
    @AppStorage("unit") var unit: TemperatureUnit = .celsius

    @Published var locationStatus: CLAuthorizationStatus = .notDetermined
    private let locationPermissionManager: LocationPermissionManager

    init(locationPermissionManager: LocationPermissionManager = .init()) {
        self.locationPermissionManager = locationPermissionManager
        self.locationStatus = locationPermissionManager.checkStatus()
    }

    func refreshLocationStatus() {
        locationStatus = locationPermissionManager.checkStatus()
    }

    func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
