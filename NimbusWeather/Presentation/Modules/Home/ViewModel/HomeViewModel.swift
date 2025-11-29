//
//  HomeViewModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain
import Combine
import CoreLocation

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var state: HomeState = .idle
    @Published var currentCondition: String?

    private let weatherUseCase: GetWeatherUseCaseProtocol
    private let locationService: LocationServiceProtocol
    private let locationProvider: UserLocationProviderProtocol

    init(
        weatherUseCase: GetWeatherUseCaseProtocol,
        locationService: LocationServiceProtocol,
        locationProvider: UserLocationProviderProtocol
    ) {
        self.weatherUseCase = weatherUseCase
        self.locationService = locationService
        self.locationProvider = locationProvider
    }

    func fetchWeather(lat: Double, lon: Double) async {
        await loadWeather(lat: lat, lon: lon)
    }

    func fetchWeatherForUserLocation() async {
        state = .loading

        do {
            let coordinate = try await locationProvider.getLocation()
            await loadWeather(lat: coordinate.latitude, lon: coordinate.longitude)
        } catch {
            state = .error("Konum alınamadı")
        }
    }
}

// MARK: - Private funcs

private extension HomeViewModel {

    func loadWeather(lat: Double, lon: Double) async {
        do {
            let weather = try await weatherUseCase.execute(lat: lat, lon: lon)

            let cityName = await locationService.resolveCityName(lat: lat, lon: lon)
            let resolvedName = cityName ?? "Current Location"
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
            timezone: weather.timezone,
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
                hour: $0.formattedHour(in: weather.timezone),
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
