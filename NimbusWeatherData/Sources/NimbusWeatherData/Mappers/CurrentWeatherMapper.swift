//
//  CurrentWeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public struct CurrentWeatherMapper {

    public static func map(_ dto: CurrentWeatherDTO) -> CurrentWeather {
        let condition = dto.weather.first

        return CurrentWeather(
            temperature: dto.temp,
            feelsLike: dto.feels_like,
            humidity: dto.humidity,
            windSpeed: dto.wind_speed,
            pressure: dto.pressure,
            condition: condition?.main ?? "",
            icon: condition?.icon ?? "",
            date: Date(timeIntervalSince1970: dto.dt),
            sunrise: Date(timeIntervalSince1970: dto.sunrise),
            sunset: Date(timeIntervalSince1970: dto.sunset)
        )
    }
}
