//
//  Endpoint.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

public extension Endpoint {
    func makeURL() -> URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
