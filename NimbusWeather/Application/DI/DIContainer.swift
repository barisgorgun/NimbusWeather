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
    let weatherRemoteDataSource: WeatherRemoteDataSourceProtocol
    let searchRemoteDataSource: SearchRemoteDataSourceProtocol
    let locationService: LocationServiceProtocol
    let locationProvider: UserLocationProviderProtocol

    // MARK: - Repositories

    let weatherRepository: WeatherRepositoryProtocol
    let searchRepository: LocationSearchRepositoryProtocol
    let favoriteCityRepository: FavoriteCityRepositoryProtocol

    // MARK: - Use Cases

    let getWeatherUseCase: GetWeatherUseCaseProtocol
    let searchLocationUseCase: SearchLocationsUseCaseProtocol
    let addFavoriteUseCase: AddFavoriteCityUseCaseProtocol
    let removeFavoriteUseCase: RemoveFavoriteCityUseCaseProtocol
    let loadFavoriteCitiesWeatherUseCase: LoadFavoriteCitiesWeatherUseCaseProtocol

    // MARK: - Storage
    private let favoriteCityStorage: FavoriteCityStorageProtocol

    // MARK: - Initialization

    init(
        apiService: APIService,
        weatherRemoteDataSource: WeatherRemoteDataSourceProtocol,
        searchRemoteDataSource: SearchRemoteDataSourceProtocol,
        locationService: LocationServiceProtocol,
        locationProvider: UserLocationProviderProtocol
    ) {
        self.apiService = apiService
        self.weatherRemoteDataSource = weatherRemoteDataSource
        self.locationService = locationService
        self.locationProvider = locationProvider
        self.weatherRepository = WeatherRepository(remote: weatherRemoteDataSource)
        self.getWeatherUseCase = GetWeatherUseCase(weatherRepository: weatherRepository)

        self.searchRemoteDataSource = searchRemoteDataSource
        self.searchRepository = SearchRepositoryImpl(remote: searchRemoteDataSource)
        self.searchLocationUseCase = SearchLocationsUseCase(searchRepository: searchRepository)

        self.favoriteCityStorage = FavoriteCityStorage()
        self.favoriteCityRepository = FavoriteCityRepositoryImpl(storage: favoriteCityStorage)
        self.addFavoriteUseCase = AddFavoriteCityUseCase(repository: favoriteCityRepository)
        self.removeFavoriteUseCase = RemoveFavoriteCityUseCase(repository: favoriteCityRepository)
        self.loadFavoriteCitiesWeatherUseCase = LoadFavoriteCitiesWeatherUseCase(repository: favoriteCityRepository, weatherService: weatherRepository)
    }

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            weatherUseCase: getWeatherUseCase,
            locationService: locationService,
            locationProvider: locationProvider
        )
    }

    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(searchUseCase: searchLocationUseCase)
    }

    func makeDetailViewModel(lat: Double, lon: Double) -> WeatherDetailViewModel {
        WeatherDetailViewModel(
            weatherUseCase: getWeatherUseCase,
            locationService: locationService,
            lat: lat,
            lon: lon
        )
    }
}
