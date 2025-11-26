//
//  CurrentWeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public struct CurrentWeatherMapper {

    public static func map(_ dto: CurrentWeatherDTO) throws -> CurrentWeather {

        guard let conditionDTO = dto.weather.first else {
            throw WeatherError.noWeatherData
        }

        return CurrentWeather(
            date: dto.dt.asDate,
            temperature: dto.temp,
            feelsLike: dto.feelsLike,
            humidity: dto.humidity,
            windSpeed: dto.windSpeed,
            pressure: dto.pressure,
            sunrise: dto.sunrise.asDate,
            sunset: dto.sunset.asDate,
            condition: conditionDTO.main,
            icon: conditionDTO.icon
        )
    }
}
