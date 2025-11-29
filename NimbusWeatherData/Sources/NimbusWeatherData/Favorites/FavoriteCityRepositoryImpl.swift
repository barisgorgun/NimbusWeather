//
//  FavoriteCityRepositoryImpl.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation
import NimbusWeatherDomain

public final class FavoriteCityRepositoryImpl: FavoriteCityRepositoryProtocol {
    private let storage: FavoriteCityStorageProtocol

    public init(storage: FavoriteCityStorageProtocol) {
        self.storage = storage
    }

    public func loadFavorites() async throws -> [FavoriteCity] {
        await storage.load()
    }

    public func saveFavorites(_ favorites: [FavoriteCity]) async throws {
        await storage.save(favorites)
    }

    public func addFavorite(_ city: FavoriteCity) async throws {
        var list = await storage.load()

        if !list.contains(where: { $0.latitude == city.latitude && $0.longitude == city.longitude }) {
            list.append(city)
            await storage.save(list)
        }
    }

    public func removeFavorite(id: UUID) async throws {
        var list = await storage.load()
        list.removeAll { $0.id == id }
        await storage.save(list)
    }
}
