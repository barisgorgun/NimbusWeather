//
//  DIContainer.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherData
import NimbusWeatherDomain

final class DIContainer {

    // MARK: - Services
        let apiService: APIService
        let weatherAPIService: WeatherAPIServiceProtocol
        let locationService: LocationServiceProtocol
        let locationProvider: UserLocationProviderProtocol

    // MARK: - Repositories
        let weatherRepository: WeatherRepositoryProtocol

        // MARK: - Use Cases
        let getWeatherUseCase: GetWeatherUseCaseProtocol


    // MARK: - Initialization

    init(
        apiService: APIService,
        weatherAPIService: WeatherAPIServiceProtocol,
        locationService: LocationServiceProtocol,
        locationProvider: UserLocationProviderProtocol
    ) {
        self.apiService = apiService
        self.weatherAPIService = weatherAPIService
        self.locationService = locationService
        self.locationProvider = locationProvider
        self.weatherRepository = WeatherRepository(apiService: weatherAPIService)
        self.getWeatherUseCase = GetWeatherUseCase(weatherRepository: weatherRepository)
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            weatherUseCase: getWeatherUseCase,
            locationService: locationService,
            locationProvider: locationProvider
        )
    }
}
