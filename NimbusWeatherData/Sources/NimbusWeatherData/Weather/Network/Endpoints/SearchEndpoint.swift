//
//  SearchEndpoint.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import Foundation

struct SearchEndpoint: Endpoint {
    let cityName: String
    let apiKey: String

    public var baseURL: String {
        "https://api.openweathermap.org"
    }
    
    public var path: String {
        "/geo/1.0/direct"
    }

    public var method: HTTPMethod {
        .get
    }

    public var queryItems: [URLQueryItem] {
        [
            .init(name: "q", value: "\(cityName)"),
            .init(name: "appid", value: apiKey),
            .init(name: "limit", value: "5")
        ]
    }
}
