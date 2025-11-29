//
//  WeatherRepository.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public final class WeatherRepository: WeatherRepositoryProtocol {

    private let remote: WeatherRemoteDataSourceProtocol

    public init(remote: WeatherRemoteDataSourceProtocol) {
        self.remote = remote
    }

    public func getWeather(lat: Double, lon: Double) async throws -> Weather {
        do {
            let dto = try await remote.fetchWeather(lat: lat, lon: lon)
            return try WeatherMapper.map(dto)

        } catch let apiError as APIError {
            throw mapAPIError(apiError)

        } catch {
            throw WeatherError.unknown
        }
    }
    // MARK: - Error Mapping

    private func mapAPIError(_ error: APIError) -> WeatherError {
        switch error {
        case .invalidURL, .requestFailed:
            return .networkUnavailable

        case .unauthorized:
            return .invalidAPIKey

        case .notFound:
            return .noWeatherData

        case .serverError:
            return .serverError(statusCode: 500)

        case .decodingError, .invalidResponse:
            return .decodingFailed

        case .unknown:
            return .unknown
        }
    }
}
