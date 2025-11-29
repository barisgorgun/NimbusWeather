//
//  DailyWeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//


import Foundation
import NimbusWeatherDomain

public struct DailyWeatherMapper {

    public static func map(_ dto: DailyWeatherDTO) throws -> DailyWeather {

        guard let conditionDTO = dto.weather.first else {
            throw WeatherError.noWeatherData
        }


        return DailyWeather(
            date: dto.dt.asDate,
            minTemp: dto.temp.min,
            maxTemp: dto.temp.max,
            icon: conditionDTO.icon,
            condition: conditionDTO.main
        )
    }
}
