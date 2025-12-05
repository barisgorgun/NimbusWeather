//
//  HomeCoordinator.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 5.12.2025.
//

import Foundation
import Combine
import SwiftUI

final class HomeCoordinator: ObservableObject {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    @ViewBuilder
    func makeLocationListView(onCitySelect: @escaping (FavoriteCityUIModel) -> Void) -> LocationListView {
        let viewModel = container.makeLocationListViewModel()
        LocationListView(viewModel: viewModel, onCitySelected: onCitySelect)
    }

    @ViewBuilder
    func makeWeatherDetailSheet(item: SearchResultUIModel) -> WeatherDetailSheet {
        let viewModel = container.makeDetailViewModel(lat: item.lat, lon: item.lon)
        WeatherDetailSheet(viewModel: viewModel)
    }

    @ViewBuilder
    func makeSettingsView() -> SettingsView {
        SettingsView()
    }

}
