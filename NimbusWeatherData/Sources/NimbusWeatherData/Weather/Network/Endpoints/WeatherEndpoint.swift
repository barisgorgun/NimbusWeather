//
//  WeatherEndpoint.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public struct WeatherEndpoint: Endpoint {
    let lat: Double
    let lon: Double
    let apiKey: String

    public var baseURL: String {
        "https://api.openweathermap.org"
    }

    public var path: String {
        "/data/3.0/onecall"
    }

    public var method: HTTPMethod {
        .get
    }

    public var queryItems: [URLQueryItem] {
        [
            .init(name: "lat", value: "\(lat)"),
            .init(name: "lon", value: "\(lon)"),
            .init(name: "appid", value: apiKey),
            .init(name: "units", value: "metric"),
            .init(name: "exclude", value: "minutely")
        ]
    }
}
