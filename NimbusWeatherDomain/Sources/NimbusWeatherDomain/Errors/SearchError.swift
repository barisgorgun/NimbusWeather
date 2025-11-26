//
//  SearchError.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public enum SearchError: Error, Sendable, Equatable {
    case networkUnavailable
    case invalidAPIKey
    case rateLimited
    case noResults
    case decodingFailed
    case serverError(statusCode: Int)
    case unknown
}
