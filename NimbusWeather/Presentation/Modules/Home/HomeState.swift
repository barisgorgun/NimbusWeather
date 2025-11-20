//
//  HomeState.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

enum HomeState {
    case idle
    case loading
    case loaded(HomeUIModel)
    case error(String)
}


struct HomeUIModel {
    let background: HomeBackgroundUIModel
    let current: CurrentWeatherUIModel
    let hourly: [HourlyWeatherUIModel]
    let daily: [DailyWeatherUIModel]
}
