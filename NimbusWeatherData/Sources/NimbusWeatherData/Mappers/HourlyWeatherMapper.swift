//
//  HourlyWeatherMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public struct HourlyWeatherMapper {

    public static func map(_ dto: HourlyWeatherDTO) -> HourlyWeather {
        let condition = dto.weather.first

        return HourlyWeather(
            date: Date(timeIntervalSince1970: dto.dt),
            temperature: dto.temp,
            icon: condition?.icon ?? "",
            condition: condition?.main ?? ""
        )
    }
}
