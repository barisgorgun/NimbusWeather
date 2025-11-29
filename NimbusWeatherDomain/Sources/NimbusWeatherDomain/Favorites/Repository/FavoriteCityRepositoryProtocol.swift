//
//  FavoriteCityRepositoryProtocol.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation

public protocol FavoriteCityRepositoryProtocol: Sendable {
    func getFavoriteCities() async throws -> [FavoriteCity]
    func addFavorite(_ city: FavoriteCity) async throws
    func removeFavorite(id: UUID) async throws
}
