//
//  WeatherError.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public enum WeatherError: Error, Equatable {
    case notFound
    case serverError
    case decodingError
    case unauthorized
    case unknown
}
