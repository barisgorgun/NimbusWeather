//
//  DailyWeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//


import Foundation
import NimbusWeatherDomain

public struct DailyWeatherMapper {

    public static func map(_ dto: DailyWeatherDTO) -> DailyWeather {
        let condition = dto.weather.first

        return DailyWeather(
            date: Date(timeIntervalSince1970: dto.dt),
            minTemp: dto.temp.min,
            maxTemp: dto.temp.max,
            icon: condition?.icon ?? "",
            condition: condition?.main ?? ""
        )
    }
}
