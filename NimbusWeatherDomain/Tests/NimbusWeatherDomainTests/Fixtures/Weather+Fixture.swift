//
//  Weather+Fixture.swift
//  NimbusWeatherDomain
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain

extension Weather {
    static func sample(condition: String) -> Weather {
        Weather(
            timezone: "Europe/Istanbul",
            current: CurrentWeather(
                date: Date(),
                temperature: 20,
                feelsLike: 18,
                humidity: 50,
                windSpeed: 3.5,
                pressure: 1010,
                sunrise: Date(),
                sunset: Date(),
                condition: condition,
                icon: "01d"
            ),
            hourly: [],
            daily: []
        )
    }
}
