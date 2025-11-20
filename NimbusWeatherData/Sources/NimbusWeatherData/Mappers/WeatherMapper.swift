//
//  WeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public struct WeatherMapper {

    public static func map(_ dto: WeatherResponseDTO) -> Weather {
        return Weather(
            current: CurrentWeatherMapper.map(dto.current),
            hourly: dto.hourly.map { HourlyWeatherMapper.map($0) },
            daily: dto.daily.map { DailyWeatherMapper.map($0) }
        )
    }
}
