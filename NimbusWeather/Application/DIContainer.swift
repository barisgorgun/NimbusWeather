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

    // MARK: - Shared Singleton Instance

    static let shared = DIContainer()

    // MARK: - Services

    private(set) var apiService: APIService
    private(set) var weatherAPIService: WeatherAPIServiceProtocol

    // MARK: - Repositories

    private(set) var weatherRepository: WeatherRepositoryProtocol

    // MARK: - Use Cases

    private(set) var getWeatherUseCase: GetWeatherUseCaseProtocol

    // MARK: - Initialization

    private init() {
        self.apiService = APIServiceImpl()

        let apiKey = Bundle.main.infoDictionary?["OPENWEATHER_API_KEY"] as? String ?? ""
        self.weatherAPIService = WeatherAPIServiceImpl(apiService: apiService, apiKey: apiKey)
        self.weatherRepository = WeatherRepository(apiService: weatherAPIService)
        self.getWeatherUseCase = GetWeatherUseCase(weatherRepository: weatherRepository)
    }

    func makeWeatherUseCase() -> GetWeatherUseCaseProtocol {
        GetWeatherUseCase(weatherRepository: weatherRepository)
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(weatherUseCase: makeWeatherUseCase())
    }
}
