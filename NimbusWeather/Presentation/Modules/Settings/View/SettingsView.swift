//
//  SettingsView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI
import CoreLocation

struct SettingsView: View {
    @EnvironmentObject var themeManager: AppThemeManager
    @StateObject private var viewModel: SettingsViewModel

    init() {
          _viewModel = StateObject(
              wrappedValue: SettingsViewModel(
                locationPermissionManager: LocationPermissionManager()
              )
          )
      }

    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    Picker("Theme", selection: $viewModel.selectedTheme) {
                        ForEach(AppTheme.allCases, id: \.self) { theme in
                            Text(theme.displayName).tag(theme)
                        }
                    }
                    .onChange(of: viewModel.selectedTheme) { _, newValue in
                        themeManager.updateTheme(newValue)
                    }
                }

                Section("Units") {
                    Picker("Temperature Unit", selection: $viewModel.unit) {
                        ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                            Text(unit.displayName).tag(unit)
                        }
                    }
                }

                Section("Location") {
                    HStack {
                        Text("Status")
                        Spacer()
                        Text(viewModel.locationStatus.description)
                            .foregroundColor(.secondary)
                    }

                    if viewModel.locationStatus == .denied ||
                        viewModel.locationStatus == .restricted {
                        Button("Open System Settings") {
                            viewModel.openSystemSettings()
                        }
                    }
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(appVersion)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(themeManager.currentTheme.colorScheme)
        .onAppear {
            viewModel.selectedTheme = themeManager.currentTheme
        }
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
        return "\(version) (\(build))"
    }
}

#Preview {
    SettingsView()
}
