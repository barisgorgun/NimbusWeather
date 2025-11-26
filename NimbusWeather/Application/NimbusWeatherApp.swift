//
//  NimbusWeatherApp.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import SwiftUI
import NimbusWeatherData

@main
struct NimbusWeatherApp: App {
    @StateObject private var themeManager = AppThemeManager()
    private let container: DIContainer

    init() {
        let apiKey = Bundle.main.infoDictionary?["OPENWEATHER_API_KEY"] as? String ?? ""

        let apiService = APIServiceImpl()
        let weatherRemoteDataSource = WeatherRemoteDataSourceImpl(apiService: apiService, apiKey: apiKey)
        let searchRemoteDataSource = SearchRemoteDataSourceImpl(apiService: apiService, apiKey: apiKey)

        self.container = DIContainer(
            apiService: apiService,
            weatherRemoteDataSource: weatherRemoteDataSource,
            searchRemoteDataSource: searchRemoteDataSource,
            locationService: LocationService(),
            locationProvider: UserLocationProvider()
        )
    }

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: container.makeHomeViewModel(), searchViewModel: container.makeSearchViewModel())
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.currentTheme.colorScheme)
        }
    }
}
