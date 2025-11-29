//
//  ContentView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import SwiftUI
import NimbusWeatherDomain
import CoreLocation

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @StateObject private var searchViewModel: SearchViewModel

    @State private var isShowingSettings = false
    @State private var isSearching = false
    @State private var isShowingLocationList = false

    private let diContainer: DIContainer
    private let permissionManager = LocationPermissionManager()

    init(
        viewModel: HomeViewModel,
        searchViewModel: SearchViewModel,
        diContainer: DIContainer
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _searchViewModel = StateObject(wrappedValue: searchViewModel)
        self.diContainer = diContainer
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView
                contentView
                    .blur(radius: isSearching ? 12 : 0)
                    .opacity(isSearching ? 0.4 : 1)
                    .animation(.easeInOut(duration: 0.25), value: isSearching)

                if isShowingLocationList {
                    ZStack {
                        LocationListView(viewModel: diContainer.makeLocationListViewModel()) { selectedCity in
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                isShowingLocationList = false
                            }

                            Task { await viewModel.fetchWeather(lat: selectedCity.lat, lon: selectedCity.lon)}
                            
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            .overlay(alignment: .bottom) {
                if !isSearching && !isShowingLocationList {
                    SearchTriggerBarView(
                        onTapSearch: {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                isSearching = true
                            }
                        }
                    ) {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                            isShowingLocationList = true
                        }
                    }
                    .padding(.bottom, 32)
                }
            }
            .overlay(alignment: .top) {
                if isSearching {
                    WeatherSearchContainerView(
                        viewModel: searchViewModel,
                        diContainer: diContainer,
                        isSearching: $isSearching
                    ) {
                        Task { await viewModel.fetchWeatherForUserLocation() }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .task { await requestPermissionAndLoad() }
            .toolbar {
                ToolbarCircleButton(systemName: "gearshape.fill") {
                    isShowingSettings = true
                }
            }
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView()
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isShowingLocationList)
    }
}

extension HomeView {
    @ViewBuilder
    private var backgroundView: some View {
        if let condition = viewModel.currentCondition {
            DynamicWeatherBackgroundView(condition: condition)
                .ignoresSafeArea()
        } else {
            Color.black.ignoresSafeArea()
        }
    }
}

extension HomeView {
    private var contentView: some View {
        VStack(spacing: 20) {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Updating Weather…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let uiModel):
                WeatherOverviewView(uiModel: uiModel) {
                    Task { await viewModel.fetchWeatherForUserLocation() }
                }
                    .transition(.opacity.combined(with: .scale))
            case .error(let message):
                WeatherErrorView(message: message) {
                    Task { await viewModel.fetchWeatherForUserLocation() }
                }
            }
        }
    }
}

extension HomeView {

    private func requestPermissionAndLoad() async {
        let status = await permissionManager.requestPermission()

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            await viewModel.fetchWeatherForUserLocation()

        default:
            await viewModel.fetchWeather(lat: 41.015137, lon: 28.97953)
        }
    }
}
