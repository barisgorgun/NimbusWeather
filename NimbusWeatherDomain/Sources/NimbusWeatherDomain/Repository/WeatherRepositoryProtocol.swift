//
//  WeatherRepositoryProtocol.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

public protocol WeatherRepositoryProtocol: Sendable {
    func getWeather(lat: Double, lon: Double) async throws -> Weather
}


//func getCachedWeather(lat: Double, lon: Double) async -> Weather?
//func saveWeatherToCache(_ weather: Weather, lat: Double, lon: Double) async
