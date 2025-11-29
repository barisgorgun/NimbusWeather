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
    case loading
    case loaded(WeatherUIModel)
    case error(String)
}

enum WeatherLoadingType: Equatable {
    case initial
    case condition(String)
}
