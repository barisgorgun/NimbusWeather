//
//  WeatherUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation
import NimbusWeatherDomain

struct WeatherUIModel: Equatable {
    let cityName: String
    let timezone: String
    let current: CurrentWeatherUIModel
    let hourly: [HourlyWeatherUIModel]
    let daily: [DailyWeatherUIModel]
}
