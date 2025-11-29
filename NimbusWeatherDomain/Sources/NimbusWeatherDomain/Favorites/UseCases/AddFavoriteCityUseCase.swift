//
//  AddFavoriteCityUseCase.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

public protocol AddFavoriteCityUseCaseProtocol {
    func execute(_ city: FavoriteCity) async throws
}

public final class AddFavoriteCityUseCase: AddFavoriteCityUseCaseProtocol {
    private let repository: FavoriteCityRepositoryProtocol

    public init(repository: FavoriteCityRepositoryProtocol) {
        self.repository = repository
    }

    public func execute(_ city: FavoriteCity) async throws {
        try await repository.addFavorite(city)
    }
}
