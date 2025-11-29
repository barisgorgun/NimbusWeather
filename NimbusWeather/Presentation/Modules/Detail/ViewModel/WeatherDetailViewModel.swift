//
//  WeatherDetailViewModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 27.11.2025.
//

import Foundation
import NimbusWeatherDomain
import Combine
import CoreLocation

@MainActor
final class WeatherDetailViewModel: ObservableObject {
    @Published var state: HomeState = .idle
    @Published var currentCondition: String?
    @Published var isAddSuccess: Bool = false

    private let weatherUseCase: GetWeatherUseCaseProtocol
    private let locationService: LocationServiceProtocol
    private let addFavoriteCityUseCase: AddFavoriteCityUseCaseProtocol
    private let lat: Double
    private let lon: Double
    private var resolvedName = ""

    init(
        weatherUseCase: GetWeatherUseCaseProtocol,
        locationService: LocationServiceProtocol,
        addFavoriteCityUseCase: AddFavoriteCityUseCaseProtocol,
        lat: Double,
        lon: Double
    ) {
        self.weatherUseCase = weatherUseCase
        self.locationService = locationService
        self.addFavoriteCityUseCase = addFavoriteCityUseCase
        self.lat = lat
        self.lon = lon
    }

    func fetchWeather() async {
        await loadWeather(lat: lat, lon: lon)
    }

    func addFavoriteCity() async {
        do {
            let favoriteCity = FavoriteCity(
                name: resolvedName,
                latitude: lat,
                longitude: lon
            )
            try await addFavoriteCityUseCase.execute(favoriteCity)
            isAddSuccess = true
        } catch {
            print("Failed to add favorite city")
        }
    }
}

// MARK: - Private funcs

private extension WeatherDetailViewModel {

    func loadWeather(lat: Double, lon: Double) async {
        do {
            let weather = try await weatherUseCase.execute(lat: lat, lon: lon)

            let cityName = await locationService.resolveCityName(lat: lat, lon: lon)
            resolvedName = cityName ?? "Current Location"
            currentCondition = weather.current.condition

            let uiModel = buildUIModel(from: weather, cityName: resolvedName)

            state = .loaded(uiModel)

        } catch {
            state = .error("Veri alınamadı")
        }
    }

    func buildUIModel(from weather: Weather, cityName: String) -> WeatherUIModel {
        WeatherUIModel(
            cityName: cityName,
            current: buildCurrentUI(from: weather),
            hourly: buildHourlyUI(from: weather),
            daily: buildDailyUI(from: weather)
        )
    }

    func buildCurrentUI(from weather: Weather) -> CurrentWeatherUIModel {
        CurrentWeatherUIModel(
            temperature: weather.current.temperature,
            condition: weather.current.condition,
            feelsLikeValue: weather.current.feelsLike,
            high: weather.daily.first?.maxTemp ?? weather.current.temperature,
            low: weather.daily.first?.minTemp ?? weather.current.temperature,
            icon: weather.current.icon,
            humidity: "\(weather.current.humidity)%",
            windSpeed: String(format: "%.2f km/h", weather.current.windSpeed),
            pressure: "\(weather.current.pressure) hPa"
        )
    }

    func buildHourlyUI(from weather: Weather) -> [HourlyWeatherUIModel] {
        weather.hourly.prefix(12).map {
            HourlyWeatherUIModel(
                hour: $0.formattedHour,
                temperature: $0.temperature,
                icon: $0.icon
            )
        }
    }

    func buildDailyUI(from weather: Weather) -> [DailyWeatherUIModel] {
        weather.daily.prefix(7).map {
            DailyWeatherUIModel(
                day: $0.formattedDay,
                minTemp: "\(Int($0.minTemp))°",
                maxTemp: "\(Int($0.maxTemp))°",
                icon: $0.icon
            )
        }
    }
}
