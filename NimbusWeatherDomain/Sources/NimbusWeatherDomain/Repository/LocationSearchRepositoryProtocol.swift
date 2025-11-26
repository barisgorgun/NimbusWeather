//
//  LocationSearchRepositoryProtocol.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public protocol LocationSearchRepositoryProtocol: Sendable {
    func search(query: String) async throws -> [LocationSearchResult]
}
