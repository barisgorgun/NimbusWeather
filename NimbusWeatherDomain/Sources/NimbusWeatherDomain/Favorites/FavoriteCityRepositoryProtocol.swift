//
//  FavoriteCityRepositoryProtocol.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

public protocol FavoriteCityRepository {
    func loadFavorites() async throws -> [FavoriteCity]
    func saveFavorites(_ favorites: [FavoriteCity]) async throws
    func addFavorite(_ city: FavoriteCity) async throws
    func removeFavorite(id: UUID) async throws
}
