//
//  APIService.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public protocol APIServiceProtocol: Sendable {
    func request<T: Decodable>(_ endpoint: any Endpoint) async throws -> T
}
