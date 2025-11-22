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

    private func loadWeather(lat: Double, lon: Double) async {
            do {
                let weather = try await weatherUseCase.execute(lat: lat, lon: lon)

                //state = .loading(.condition(weather.current.condition))

                let cityName = await locationService.resolveCityName(lat: lat, lon: lon)
                let resolvedName = cityName ?? "Current Location"

                let uiModel = buildUIModel(from: weather, cityName: resolvedName)

                try? await Task.sleep(for: .milliseconds(600))

                state = .loaded(uiModel)

            } catch {
                state = .error("Veri alınamadı")
            }
        }

    private func buildUIModel(from weather: Weather, cityName: String) -> HomeUIModel {

            let isNightNow = isNight(
                currentTime: weather.current.date.timeIntervalSince1970,
                sunrise: weather.current.sunrise.timeIntervalSince1970,
                sunset: weather.current.sunset.timeIntervalSince1970
            )

            let backgroundStyle = WeatherBackgroundStyleMapper.map(
                condition: weather.current.condition,
                isNight: isNightNow
            )

            return HomeUIModel(
                cityName: cityName,
                background: weather.current.condition,//HomeBackgroundUIModel(style: backgroundStyle),
                current: buildCurrentUI(from: weather),
                hourly: buildHourlyUI(from: weather),
                daily: buildDailyUI(from: weather)
            )
        }

    private func buildCurrentUI(from weather: Weather) -> CurrentWeatherUIModel {
            CurrentWeatherUIModel(
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
        }

    private func buildHourlyUI(from weather: Weather) -> [HourlyWeatherUIModel] {
          weather.hourly.prefix(12).map {
              HourlyWeatherUIModel(
                  hour: $0.formattedHour,
                  temperature: "\(Int($0.temperature))°",
                  icon: $0.icon
              )
          }
      }

    private func buildDailyUI(from weather: Weather) -> [DailyWeatherUIModel] {
           weather.daily.prefix(7).map {
               DailyWeatherUIModel(
                   day: $0.formattedDay,
                   minTemp: "\(Int($0.minTemp))°",
                   maxTemp: "\(Int($0.maxTemp))°",
                   icon: $0.icon
               )
           }
       }

    private func isNight(
        currentTime: TimeInterval,
        sunrise: TimeInterval,
        sunset: TimeInterval
    ) -> Bool {
        currentTime < sunrise || currentTime > sunset
    }
}
