//
//  WeatherSearchContainerView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import SwiftUI

struct WeatherSearchContainerView: View {
    @StateObject var viewModel: SearchViewModel
    @State private var selectedItem: SearchResultUIModel?
    @Binding var isSearching: Bool
    @EnvironmentObject var coordinator: HomeCoordinator
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isSearchFieldFocused: Bool

    let onLocationRequest: () -> Void

    init(
        viewModel: SearchViewModel,
        isSearching: Binding<Bool>,
        onLocationRequest: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isSearching = isSearching
        self.onLocationRequest = onLocationRequest
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 12) {
                activeSearchBar
                    .padding(.top, 16)
                    .padding(.horizontal, 16)

                SearchResultsListView(items: viewModel.results) { item in
                    selectedItem = item
                }
                .padding(.top, 4)
            }
        }
        .sheet(item: $selectedItem) { item in
            coordinator.makeWeatherDetailSheet(item: item)
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                isSearchFieldFocused = true
            }
        }
        .onDisappear {
            isSearchFieldFocused = false
            viewModel.query = ""
            viewModel.results.removeAll()
        }
    }

    private func dismissSearch() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            isSearching = false
            viewModel.query = ""
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil
            )
        }
    }

    private var activeSearchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField("Search location", text: $viewModel.query)
                .focused($isSearchFieldFocused)
                .textFieldStyle(.plain)

            Button("Cancel") {
                dismissSearch()
            }
            .foregroundColor(.blue)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(14)
        .shadow(
            color: colorScheme == .dark
            ? Color.white.opacity(0.18)
            : Color.black.opacity(0.25),
            radius: 20,
            y: 12
        )
    }
}
