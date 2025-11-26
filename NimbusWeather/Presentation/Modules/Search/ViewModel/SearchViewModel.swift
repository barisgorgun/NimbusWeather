//
//  SearchViewModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation
import Combine
import NimbusWeatherDomain

@MainActor
final class SearchViewModel: ObservableObject {
    // MARK: - Publish states

    @Published var query: String = ""
    @Published var results: [SearchResultUIModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // MARK: - Dependencies
    private let searchUseCase: SearchLocationsUseCaseProtocol

    private var searchTask: Task<Void, Never>? = nil

    init(searchUseCase: SearchLocationsUseCaseProtocol) {
        self.searchUseCase = searchUseCase
        observeQuery()
    }

    private func observeQuery() {
        searchTask = Task {
            for await newQuery in $query.values {
                await performDebouncedSearch(query: newQuery)
            }
        }
    }

    private func performDebouncedSearch(query: String) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            results = []
            return
        }

        try? await Task.sleep(for: .milliseconds(400))

        await search(query)
    }

    private func search(_ query: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let searchResults = try await searchUseCase.execute(query: query)

            let uiModels = searchResults.map {
                SearchResultUIModel(
                    name: $0.name,
                    country: $0.country,
                    lat: $0.lat,
                    lon: $0.lon,
                    state: $0.state
                )
            }

            let unique = Dictionary(grouping: uiModels, by: { $0.country })
                .compactMap { $0.value.first }

            results = unique

        } catch let err as SearchError {
            errorMessage = mapSearchError(err)
        } catch {
            errorMessage = "Unknown error"
        }

        isLoading = false
    }

    private func mapSearchError(_ error: SearchError) -> String {
        switch error {
        case .networkUnavailable: 
            "No network connection"
        case .invalidAPIKey: 
            "Invalid API key"
        case .rateLimited: 
            "You are rate-limited"
        case .noResults: 
            "No results found"
        case .decodingFailed: 
            "Failed to decode response"
        case .serverError(let code): 
            "Server error: \(code)"
        case .unknown: 
            "Unknown error"
        }
    }
}
