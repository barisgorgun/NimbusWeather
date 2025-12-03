//
//  FavoriteCityStorage.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation
import NimbusWeatherDomain

public protocol FavoriteCityStorageProtocol: Sendable {
    func load() async -> [FavoriteCity]
    func save(_ favorites: [FavoriteCity]) async
}

public actor FavoriteCityStorage: FavoriteCityStorageProtocol {
    private let key = "FAVORITE_CITIES"
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func load() async -> [FavoriteCity] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([FavoriteCity].self, from: data)) ?? []
    }

    public func save(_ favorites: [FavoriteCity]) async {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
