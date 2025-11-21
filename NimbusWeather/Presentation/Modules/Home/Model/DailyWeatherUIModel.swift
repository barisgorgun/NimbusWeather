//
//  DailyWeatherUIModel.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 20.11.2025.
//

import Foundation

struct DailyWeatherUIModel: Identifiable, Equatable {
    let id = UUID()
    let day: String
    let minTemp: String
    let maxTemp: String
    let icon: String

    var iconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@4x.png")
    }
}

extension DailyWeatherUIModel {
    var rangeRatio: CGFloat {
        let minV = CGFloat(Int(minTemp.replacingOccurrences(of: "°", with: "")) ?? 0)
        let maxV = CGFloat(Int(maxTemp.replacingOccurrences(of: "°", with: "")) ?? 0)

        let range = max(maxV - minV, 1)
        return CGFloat(range) / 20
    }
}
