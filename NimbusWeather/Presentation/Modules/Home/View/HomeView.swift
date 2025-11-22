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
    @State private var permissionManager = LocationPermissionManager()
    @State private var currentCondition: String? = nil
    @State private var isShowingSettings = false

    init(viewModel: HomeViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView
                contentView
            }
            .task { await requestPermissionAndLoad() }
            .onChange(of: viewModel.state) { _, newValue in
                updateBackground(for: newValue)
            }
            .toolbar {
              settingsButton
            }
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView()
        }
    }
}

extension HomeView {
    @ViewBuilder
    private var backgroundView: some View {
        if let condition = currentCondition {
            DynamicWeatherBackgroundView(condition: condition)
                .ignoresSafeArea()
        } else {
            Color.black.ignoresSafeArea()
        }
    }
}

extension HomeView {
    @ToolbarContentBuilder
    private var settingsButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                isShowingSettings = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .symbolRenderingMode(.hierarchical)
            }
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
                loadedView(uiModel)
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

    private func loadedView(_ uiModel: HomeUIModel) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {
                HomeHeaderView(
                    location: uiModel.cityName,
                    condition: uiModel.current.condition,
                    date: Date()
                )

                CurrentWeatherCardView(model: uiModel.current)

                MetricsGridView(
                    humidity: uiModel.current.humidity,
                    wind: uiModel.current.windSpeed,
                    pressure: uiModel.current.pressure,
                    feelsLikeValue: uiModel.current.feelsLikeValue
                )

                HourlyForecastScrollView(items: uiModel.hourly)

                DailyForecastListView(items: uiModel.daily)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 32)
        }
    }

    private func updateBackground(for state: HomeState) {
        guard case .loaded(let uiModel) = state else {
            return
        }

        withAnimation(.easeInOut(duration: 0.6)) {
            currentCondition = "snow" //uiModel.current.condition
        }
    }

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
