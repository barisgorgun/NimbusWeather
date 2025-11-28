//
//  WeatherDetailSheet.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import SwiftUI

struct WeatherDetailSheet: View {
    @StateObject private var viewModel: WeatherDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: WeatherDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView
                contentView
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ToolbarCircleButton(systemName: "xmark") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    ToolbarCircleButton(systemName: "plus") {
                        // will be added action
                    }
                }
            }
        }
        .task { await viewModel.fetchWeather() }
    }
}

extension WeatherDetailSheet {
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

extension WeatherDetailSheet {
    private var contentView: some View {
        VStack(spacing: 20) {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Updating Weather…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded(let uiModel):
                WeatherOverviewView(uiModel: uiModel)
                    .transition(.opacity.combined(with: .scale))
            case .error(let message):
                WeatherErrorView(message: message) {
                    Task { await viewModel.fetchWeather() }
                }
            }
        }
    }
}
