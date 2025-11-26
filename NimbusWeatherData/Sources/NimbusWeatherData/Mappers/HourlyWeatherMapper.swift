//
//  HourlyWeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public struct HourlyWeatherMapper {

    public static func map(_ dto: HourlyWeatherDTO) throws -> HourlyWeather {

        guard let conditionDTO = dto.weather.first else {
            throw WeatherError.noWeatherData
        }

        let condition = conditionDTO.toDomain()

        return HourlyWeather(
            date: dto.dt.asDate,
            temperature: dto.temp,
            condition: condition
        )
    }
}
