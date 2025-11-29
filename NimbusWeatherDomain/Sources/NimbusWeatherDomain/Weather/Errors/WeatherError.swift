//
//  WeatherError.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public enum WeatherError: Error, Sendable, Equatable {
    case networkUnavailable
    case invalidRequest
    case invalidAPIKey
    case rateLimited
    case decodingFailed
    case noWeatherData
    case serverError(statusCode: Int)
    case unknown
}
