//
//  WeatherBackgroundStyle.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import SwiftUI

public enum WeatherBackgroundStyle {
    case clear
    case clouds
    case rain
    case thunderstorm
    case snow
    case fog
    case nightClear
    case nightClouds

    var gradient: LinearGradient {
        switch self {

        case .clear:
            LinearGradient(
                colors: [
                    Color(hex: "#4facfe"),
                    Color(hex: "#00f2fe")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case .clouds:
            LinearGradient(
                colors: [
                    Color(hex: "#a18cd1"),
                    Color(hex: "#fbc2eb")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case .rain:
            LinearGradient(
                colors: [
                    Color(hex: "#667db6"),
                    Color(hex: "#0082c8")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case .thunderstorm:
            LinearGradient(
                colors: [
                    Color(hex: "#373B44"),
                    Color(hex: "#4286f4")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case .snow:
            LinearGradient(
                colors: [
                    Color(hex: "#e0eafc"),
                    Color(hex: "#cfdef3")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case .fog:
            LinearGradient(
                colors: [
                    Color(hex: "#757f9a"),
                    Color(hex: "#d7dde8")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case .nightClear:
            LinearGradient(
                colors: [
                    Color(hex: "#0F2027"),
                    Color(hex: "#2C5364")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

        case .nightClouds:
            LinearGradient(
                colors: [
                    Color(hex: "#232526"),
                    Color(hex: "#414345")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
