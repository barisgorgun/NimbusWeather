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
        }
        .padding()
        .task {
            await viewModel.fetchWeather(lat: 41.015137, lon: 28.97953)
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch viewModel.state {
        case .loaded(let uiModel):
            uiModel.background.style.gradient
                .ignoresSafeArea()

        case .loading:
            LinearGradient(
                colors: [.gray, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

        default:
            Color.black.ignoresSafeArea()
        }
    }
}
