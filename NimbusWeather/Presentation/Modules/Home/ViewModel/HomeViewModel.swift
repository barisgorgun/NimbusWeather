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
        state = .initialLoading

        do {
            let weather = try await weatherUseCase.execute(lat: lat, lon: lon)

            self.state = .weatherLoading(weather.current.condition)

            let cityName = await locationService.resolveCityName(lat: lat, lon: lon)
            let resolvedName = cityName ?? "Current Location"

            let uiModel = mapToUIModel(weather: weather, cityName: resolvedName)
            state = .loaded(uiModel)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func fetchWeatherForUserLocation() async {
        state = .initialLoading

        do {
            let coordinate = try await locationProvider.getLocation()

            let lat = coordinate.latitude
            let lon = coordinate.longitude

            let weather = try await weatherUseCase.execute(lat: lat, lon: lon)

            state = .weatherLoading(weather.current.condition)

            let cityName = await locationService.resolveCityName(lat: lat, lon: lon)

            let resolvedName = cityName ?? "Your Location"

            let uiModel = mapToUIModel(weather: weather, cityName: resolvedName)

            state = .loaded(uiModel)

        } catch {
            state = .error(error.localizedDescription)
        }
    }

    private func mapToUIModel(weather: Weather, cityName: String) -> HomeUIModel {
        let isNightNow = isNight(
            currentTime: weather.current.date.timeIntervalSince1970,
            sunrise: weather.current.sunrise.timeIntervalSince1970,
            sunset: weather.current.sunset.timeIntervalSince1970
        )

        let backgroundStyle = WeatherBackgroundStyleMapper.map(
            condition: weather.current.condition,
            isNight: isNightNow
        )

        let backgroundUI = HomeBackgroundUIModel(style: backgroundStyle)

        let currentUI = CurrentWeatherUIModel(
            temperature: "\(Int(weather.current.temperature))°",
            condition: weather.current.condition,
            feelsLikeDescription: "Feels like \(weather.current.feelsLike)°",
            feelsLikeValue: "\(weather.current.feelsLike)°",
            high: "\(Int(weather.daily.first?.maxTemp ?? weather.current.temperature))°",
            low: "\(Int(weather.daily.first?.minTemp ?? weather.current.temperature))°",
            icon: weather.current.icon,
            humidity: "\(weather.current.humidity)%",
            windSpeed: String(format: "%.2f km/h", weather.current.windSpeed),
            pressure: "\(weather.current.pressure) hPa"
        )

        let hourlyUI = weather.hourly.prefix(12).map { hour in
            HourlyWeatherUIModel(
                hour: hour.formattedHour,
                temperature: "\(Int(hour.temperature))°",
                icon: hour.icon
            )
        }

        let dailyUI = weather.daily.prefix(7).map { day in
            DailyWeatherUIModel(
                day: day.formattedDay,
                minTemp: "\(Int(day.minTemp))°",
                maxTemp: "\(Int(day.maxTemp))°",
                icon: day.icon
            )
        }

        return HomeUIModel(
            cityName: cityName,
            background: backgroundUI,
            current: currentUI,
            hourly: hourlyUI,
            daily: dailyUI
        )
    }

    private func isNight(
        currentTime: TimeInterval,
        sunrise: TimeInterval,
        sunset: TimeInterval
    ) -> Bool {
        currentTime < sunrise || currentTime > sunset
    }
}
