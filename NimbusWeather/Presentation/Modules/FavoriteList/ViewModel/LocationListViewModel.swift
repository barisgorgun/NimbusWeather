//
//  LocationListViewModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 29.11.2025.
//

import Foundation
import Combine
import NimbusWeatherDomain
import SwiftUI

@MainActor
final class LocationListViewModel: ObservableObject {
    private let removeFavoriteUseCase: RemoveFavoriteCityUseCaseProtocol
    private let loadFavoriteCitiesWeather : LoadFavoriteCitiesWeatherUseCaseProtocol

    @Published private(set) var state: FavoriteState = .idle
    private var localCities: [FavoriteCityUIModel] = []

    init(
        removeFavoriteUseCase: RemoveFavoriteCityUseCaseProtocol,
        loadFavoriteCitiesWeather: LoadFavoriteCitiesWeatherUseCaseProtocol
    ) {
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.loadFavoriteCitiesWeather = loadFavoriteCitiesWeather
    }

    func load() async {
        state = .loading

        do {
            let cities = try await loadFavoriteCitiesWeather.execute()
            localCities = cities.map { $0.toUIModel }

            state = cities.isEmpty ? .empty : .loaded(localCities)

        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func removeFavorite(at offsets: IndexSet) async {
        for index in offsets {
            let city = localCities[index]
            try? await removeFavoriteUseCase.execute(city.id)
        }

        localCities.remove(atOffsets: offsets)

        state = localCities.isEmpty ? .empty : .loaded(localCities)
    }
}
