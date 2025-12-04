//
//  LocationListView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 28.11.2025.
//

import SwiftUI

struct LocationListView: View {
    @StateObject var viewModel: LocationListViewModel
    let onCitySelected: (FavoriteCityUIModel) -> Void

    init(viewModel: LocationListViewModel, onCitySelected: @escaping (FavoriteCityUIModel) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onCitySelected = onCitySelected
    }

    var body: some View {
        NavigationStack {
            ZStack {
                SharedBackgroundView()

                contentView
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await viewModel.load()
        }
    }
}

extension LocationListView {
    private var contentView: some View {
        VStack(spacing: 20) {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Updating Weather…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let items):
                favoritesList(items)
            case .error(let message):
                WeatherErrorView(message: message) { }
            case .empty:
                emptyStateView
            }
        }
    }

    func favoritesList(_ items: [FavoriteCityUIModel]) -> some View {
        List {
            ForEach(items) { item in
                FavoriteCityCardView(model: item)
                    .onTapGesture {
                        onCitySelected(item)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .onDelete { index in
                Task { await viewModel.removeFavorite(at: index) }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.clear)
    }

    var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "mappin.slash")
                .font(.system(size: 40, weight: .semibold))
                .foregroundStyle(.white.opacity(0.7))

            Text("No Favorite Cities")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)

            Text("Add a city from the weather detail screen.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
