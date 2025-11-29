//
//  FavoriteState.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

enum FavoriteState: Equatable {
    case idle
    case loading
    case loaded([FavoriteCityUIModel])
    case error(String)
    case empty
}
