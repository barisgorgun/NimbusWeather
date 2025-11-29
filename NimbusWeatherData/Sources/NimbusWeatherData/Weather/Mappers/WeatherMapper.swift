//
//  WeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public struct WeatherMapper {

    public static func map(_ dto: WeatherResponseDTO) throws -> Weather {

        let current = try CurrentWeatherMapper.map(dto.current)
        let hourly = try dto.hourly.map { try HourlyWeatherMapper.map($0) }
        let daily = try dto.daily.map { try DailyWeatherMapper.map($0) }

        return Weather(
            current: current,
            hourly: hourly,
            daily: daily
        )
    }
}
