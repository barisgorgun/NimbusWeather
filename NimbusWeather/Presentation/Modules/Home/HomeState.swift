//
//  HomeState.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

enum HomeState: Equatable {
    case idle
    case initialLoading
    case weatherLoading(String)
    case loaded(HomeUIModel)
    case error(String)
}


struct HomeUIModel: Equatable {
    let cityName: String
    let background: HomeBackgroundUIModel
    let current: CurrentWeatherUIModel
    let hourly: [HourlyWeatherUIModel]
    let daily: [DailyWeatherUIModel]
}
