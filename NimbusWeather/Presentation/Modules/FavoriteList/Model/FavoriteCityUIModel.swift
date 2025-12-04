//
//  FavoriteCityUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 28.11.2025.
//

import Foundation

struct FavoriteCityUIModel: Identifiable, Equatable {
    let id: UUID
    let lat: Double
    let lon: Double
    let city: String
    let time: String
    let condition: String
    let temperature: Double
    let high: Double
    let low: Double
    let backgroundImage: String
}
