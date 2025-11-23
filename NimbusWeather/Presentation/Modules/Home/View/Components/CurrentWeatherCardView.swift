//
//  CurrentWeatherCardView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct CurrentWeatherCardView: View {
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius
    let model: CurrentWeatherUIModel

    var body: some View {
        HStack(spacing: 20) {
            CachedAsyncImage(url: model.iconURL)
                .frame(width: 90, height: 90)
                .shadow(color: .black.opacity(0.25), radius: 10)

            VStack(alignment: .leading, spacing: 8) {
                Text(model.temperature.formattedTemperature(unit: unit))
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.7)

                HStack(spacing: 12) {
                    Text("H: \(model.high.formattedTemperature(unit: unit))")
                    Text("L: \(model.low.formattedTemperature(unit: unit))")
                }
                .font(.headline)
                .foregroundColor(.white.opacity(0.85))

                Text("Feels like \(model.feelsLikeValue.formattedTemperature(unit: unit))")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    CurrentWeatherCardView(
        model: CurrentWeatherUIModel(
            temperature: 2.04,
            condition: "Cloudy",
            feelsLikeValue: 25.0,
            high: 27.0,
            low: 18.0,
            icon: "03d",
            humidity: "65",
            windSpeed: "14 km/h",
            pressure: "1012 hPa"
        )
    )
    .padding()
    .background(
        LinearGradient(colors: [.blue, .purple],
                       startPoint: .top,
                       endPoint: .bottom)
    )
}
