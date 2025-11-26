//
//  SearchLocationsUseCase.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public protocol SearchLocationsUseCaseProtocol: Sendable {
    func execute(query: String) async throws -> [LocationSearchResult]
}

public final class SearchLocationsUseCase: SearchLocationsUseCaseProtocol {
    private let searchRepository: LocationSearchRepositoryProtocol

    public init(searchRepository: LocationSearchRepositoryProtocol) {
        self.searchRepository = searchRepository
    }
    
    public func execute(query: String) async throws -> [LocationSearchResult] {
        try await searchRepository.search(query: query)
    }
}
