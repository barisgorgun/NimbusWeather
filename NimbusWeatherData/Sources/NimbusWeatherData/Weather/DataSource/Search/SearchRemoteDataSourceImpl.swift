//
//  SearchRemoteDataSourceImpl.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

public final class SearchRemoteDataSourceImpl: SearchRemoteDataSourceProtocol {
    private let apiService: APIService
    private let apiKey: String

    public init(apiService: APIService, apiKey: String) {
        self.apiService = apiService
        self.apiKey = apiKey
    }

    public func search(query: String) async throws -> [SearchLocationDTO] {
        let endpoint = SearchEndpoint(cityName: query, apiKey: apiKey)
        return try await apiService.request(endpoint)
    }
}
