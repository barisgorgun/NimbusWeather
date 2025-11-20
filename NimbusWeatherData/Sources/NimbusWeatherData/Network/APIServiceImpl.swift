//
//  APIServiceImpl.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public final class APIServiceImpl: APIService {

    public init() { }

    public func request<T>(_ endpoint: any Endpoint) async throws -> T where T : Decodable {

        guard let url = endpoint.makeURL() else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200...299:
                break
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            case 500...599:
                throw APIError.serverError
            default:
                throw APIError.unknown
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingError
            }

        } catch {
            throw APIError.requestFailed
        }
    }
}
