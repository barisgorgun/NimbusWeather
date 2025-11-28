//
//  FavoriteCityUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 28.11.2025.
//

import Foundation

struct FavoriteCityUIModel: Identifiable {
    let id = UUID()

    let city: String
    let time: String
    let condition: String
    let temperature: String
    let high: String
    let low: String
    let backgroundImage: String
}
