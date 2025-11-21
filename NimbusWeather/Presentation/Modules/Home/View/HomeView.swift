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
    @State private var backgroundGradient: AnyView = AnyView(
        LinearGradient(
            colors: [
                Color(red: 0.10, green: 0.12, blue: 0.22),
                Color(red: 0.05, green: 0.06, blue: 0.13)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    )

    init(viewModel: HomeViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            contentView
        }
        .task {
            let status = await permissionManager.requestPermission()

            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                await viewModel.fetchWeatherForUserLocation()

            case .denied, .restricted:
                await viewModel.fetchWeather(lat: 41.015137, lon: 28.97953)

            default:
                break
            }
        }
        .onChange(of: viewModel.state) { _, newState in
            if case .loaded(let uiModel) = newState {
                withAnimation(.easeInOut(duration: 0.6)) {
                    backgroundGradient = AnyView(uiModel.background.style.gradient)
                }
            }
        }
    }
}

extension HomeView {
    private var contentView: some View {
        VStack(spacing: 20) {
            switch viewModel.state {
            case .idle, .initialLoading:
                ZStack {
                    WeatherLoadingView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            case .weatherLoading(let weather):
                ZStack {
                    DynamicWeatherLoadingView(condition: weather)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            case .loaded(let uiModel):
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
            case .error(let message):
                WeatherErrorView(message: message) {
                    Task { await viewModel.fetchWeatherForUserLocation() }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
