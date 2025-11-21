//
//  ContentView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import SwiftUI
import NimbusWeatherDomain

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }

    var body: some View {
        ZStack {
            backgroundView
            contentView
        }
        .task {
            await viewModel.fetchWeather(lat: 41.015137, lon: 28.97953)
        }
    }

    private var backgroundView: some View {
        Group {
            switch viewModel.state {
            case .loaded(let uiModel):
                uiModel.background.style.gradient
            case .loading:
                LinearGradient(
                    colors: [.black.opacity(0.4), .black],
                    startPoint: .top,
                    endPoint: .bottom
                )
            case .error(_):
                LinearGradient(
                    colors: [.red.opacity(0.6), .black],
                    startPoint: .top,
                    endPoint: .bottom
                )
            default:
                Color.black
            }
        }
        .animation(.easeInOut(duration: 0.35), value: viewModel.state)
        .ignoresSafeArea()
    }
}

extension HomeView {
    private var contentView: some View {
        VStack(spacing: 20) {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            case .loaded(let uiModel):
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        HomeHeaderView(
                            location: "Istanbul",
                            condition: uiModel.current.condition,
                            date: Date()
                        )

                        CurrentWeatherCardView(model: uiModel.current)

                        MetricsGridView(
                            humidity: uiModel.current.humidity,
                            wind: uiModel.current.windSpeed,
                            pressure: uiModel.current.pressure,
                            feelsLike: uiModel.current.feelsLike
                        )

                        HourlyForecastScrollView(items: uiModel.hourly)

                        DailyForecastListView(items: uiModel.daily)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 32)
                }
            case .error(let error):
                Text(error)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
