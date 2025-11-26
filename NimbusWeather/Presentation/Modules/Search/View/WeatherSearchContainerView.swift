//
//  WeatherSearchContainerView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import SwiftUI

struct WeatherSearchContainerView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Binding var isSearching: Bool
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var isSearchFieldFocused: Bool

    var onSelect: (SearchResultUIModel) -> Void
    var onLocationRequest: () -> Void

    var body: some View {
        VStack {
            if isSearching {
                activeSearchBar
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                    .padding(.top, 16)
                    .offset(y: 0)
                    .opacity(1)
                    .animation(.easeOut(duration: 0.25), value: isSearching)

                SearchResultsListView(items: viewModel.results) { item in
                    onSelect(item)
                }
            } else {
                Spacer()
                searchTriggerBar
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                    .padding(.bottom, 32)
                    .offset(y: 0)
                    .opacity(1)
                    .animation(.easeOut(duration: 0.25), value: isSearching)
            }
        }
        .onChange(of: isSearching) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    isSearchFieldFocused = true
                }
            } else {
                isSearchFieldFocused = false
                viewModel.query = ""
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.9), value: isSearching)
    }

    var searchTriggerBar: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Search location")
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(14)
            .onTapGesture {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                    isSearching = true
                }
            }

            Button {
                onLocationRequest()
            } label: {
                Image(systemName: "location.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .shadow(
            color: colorScheme == .dark
            ? Color.white.opacity(0.18)
            : Color.black.opacity(0.25),
            radius: 20,
            y: 12
        )
    }

    var activeSearchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search location", text: $viewModel.query)
                .focused($isSearchFieldFocused)
                .textFieldStyle(.plain)

            Button("Cancel") {
                viewModel.query = ""
                isSearching = false
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
