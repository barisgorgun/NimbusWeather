//
//  SearchRemoteDataSourceProtocol.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public protocol SearchRemoteDataSourceProtocol: Sendable {
    func search(query: String) async throws -> [SearchLocationDTO]
}
