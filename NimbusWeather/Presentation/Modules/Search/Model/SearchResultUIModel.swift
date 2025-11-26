//
//  SearchResultUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

struct SearchResultUIModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    let state: String?
}
