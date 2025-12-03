//
//  FavoriteCityStorage.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation
import NimbusWeatherDomain

public protocol FavoriteCityStorageProtocol {
    func load() async -> [FavoriteCity]
    func save(_ favorites: [FavoriteCity]) async
}

public actor FavoriteCityStorage: FavoriteCityStorageProtocol {
    private let key = "FAVORITE_CITIES"
    private let container: UserDefaultsContainer

    public init() {
        self.container = UserDefaultsContainer(.standard)
    }

    public init(container: UserDefaultsContainer) {
        self.container = container
    }

    public func load() async -> [FavoriteCity] {
        let userDefaults = container.instance
        guard let data = userDefaults.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([FavoriteCity].self, from: data)) ?? []
    }

    public func save(_ favorites: [FavoriteCity]) async {
        let userDefaults = container.instance
        if let data = try? JSONEncoder().encode(favorites) {
            userDefaults.set(data, forKey: key)
        }
    }
}
