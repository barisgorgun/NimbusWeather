//
//  SearchRepositoryImpl.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import NimbusWeatherDomain

public final class SearchRepositoryImpl: LocationSearchRepositoryProtocol {
    private let remote: SearchRemoteDataSourceProtocol

    public init(remote: SearchRemoteDataSourceProtocol) {
        self.remote = remote
    }

    public func search(query: String) async throws -> [LocationSearchResult] {
        do {
            let dtoList = try await remote.search(query: query)

            if dtoList.isEmpty {
                throw SearchError.noResults
            }

            return dtoList.map { SearchLocationMapper.map($0) }
        } catch let apiError as APIError {
            throw mapAPIError(apiError)

        } catch {
            throw SearchError.unknown
        }
    }

    private func mapAPIError(_ error: APIError) -> SearchError {
        switch error {
        case .invalidURL, .requestFailed:
            return .networkUnavailable
        case .unauthorized:
            return .invalidAPIKey
        case .notFound:
            return .noResults
        case .serverError:
            return .serverError(statusCode: 500)
        case .decodingError, .invalidResponse:
            return .decodingFailed
        case .unknown:
            return .unknown
        }
    }
}
