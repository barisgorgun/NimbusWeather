//
//  WeatherEndpoint.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public enum WeatherEndpoint: Endpoint {
    case fetchWeather(lat: Double, lon: Double, apiKey: String)

    public var baseURL: String {
        "https://api.openweathermap.org"
    }

    public var path: String {
        switch self {
        case .fetchWeather:
            return "/data/3.0/onecall"
        }
    }

    public var method: String { "GET" }

    public var queryItems: [URLQueryItem] {
        switch self {
        case .fetchWeather(let lat, let lon, let apiKey):
            return [
                .init(name: "lat", value: "\(lat)"),
                .init(name: "lon", value: "\(lon)"),
                .init(name: "appid", value: apiKey),
                .init(name: "units", value: "metric"),
                .init(name: "exclude", value: "minutely")
            ]
        }
    }
}
