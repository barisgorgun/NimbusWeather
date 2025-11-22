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
    @AppStorage("unit") var unit: TemperatureUnit = .celsius

    @Published var selectedTheme: AppTheme = .system
    @Published var locationStatus: CLAuthorizationStatus = .notDetermined

    private let locationPermissionManager: LocationPermissionManager

    init(locationPermissionManager: LocationPermissionManager) {
        self.locationPermissionManager = locationPermissionManager
        self.locationStatus = locationPermissionManager.checkStatus()
    }

    func refreshLocationStatus() {
        locationStatus = locationPermissionManager.checkStatus()
    }

    func requestLocationPermission() async {
        let result = await locationPermissionManager.requestPermission()
        self.locationStatus = result
    }

    func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
