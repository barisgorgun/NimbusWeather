//
//  APIError.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public enum APIError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case unauthorized
    case notFound
    case serverError
    case decodingError
    case unknown
    case requestFailed
}
