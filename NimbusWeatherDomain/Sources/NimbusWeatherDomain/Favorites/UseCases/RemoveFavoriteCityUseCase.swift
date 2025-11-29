//
//  RemoveFavoriteCityUseCase.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

public protocol RemoveFavoriteCityUseCaseProtocol {
    func execute(_ id: UUID) async throws
}

public final class RemoveFavoriteCityUseCase: RemoveFavoriteCityUseCaseProtocol {
    private let repository: FavoriteCityRepositoryProtocol

    public init(repository: FavoriteCityRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ id: UUID) async throws {
        try await repository.removeFavorite(id: id)
    }
}
