//
//  FavoriteCityWeather.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

public struct FavoriteCityWeather: Sendable, Equatable {
    public let city: FavoriteCity
    public let weather: Weather

    public init(city: FavoriteCity, weather: Weather) {
        self.city = city
        self.weather = weather
    }
}
