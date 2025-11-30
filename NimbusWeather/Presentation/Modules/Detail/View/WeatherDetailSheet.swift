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
                        Task {
                            do {
                                await viewModel.addFavoriteCity()

                                try? await Task.sleep(nanoseconds: 500_000_000)

                                dismiss()
                            }
                        }
                    }
                }
            }
        }
        .overlay {
            if viewModel.isAddSuccess {
                successOverlay
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
                WeatherOverviewView(uiModel: uiModel, showLocationButton: false) { }
                     .transition(.opacity.combined(with: .scale))
            case .error(let message):
                WeatherErrorView(message: message) {
                    Task { await viewModel.fetchWeather() }
                }
            }
        }
    }

    private var successOverlay: some View {
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                .frame(width: 120, height: 120)
                .overlay(
                    Circle()
                        .stroke(Color.cyan.opacity(0.6), lineWidth: 3)
                )
                .shadow(radius: 15)

            Image(systemName: "checkmark")
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.green)
        }
        .transition(.scale.combined(with: .opacity))
    }
}
