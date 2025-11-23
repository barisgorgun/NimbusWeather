//
//  WeatherRepository.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation
import NimbusWeatherDomain

public final class WeatherRepository: WeatherRepositoryProtocol {
    private let apiService: WeatherAPIServiceProtocol

    public init(apiService: WeatherAPIServiceProtocol) {
        self.apiService = apiService
    }

    public func getWeather(lat: Double, lon: Double) async throws -> Weather {
        do {
            let dto = try await apiService.fetchWeather(lat: lat, lon: lon)

            return WeatherMapper.map(dto)

        } catch let error as APIError {
            throw mapAPIError(error)
        } catch {
            throw WeatherError.unknown
        }
    }

    // MARK: - Error Mapping

    private func mapAPIError(_ error: APIError) -> WeatherError {
        switch error {
        case .invalidURL, .requestFailed, .notFound, .unknown:
            .unknown
        case .unauthorized:
            .unauthorized
        case .serverError:
            .serverError
        case .decodingError:
            .decodingError
        case .invalidResponse:
            .decodingError
        }
    }
}
