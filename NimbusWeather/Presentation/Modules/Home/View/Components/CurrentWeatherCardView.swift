//
//  CurrentWeatherCardView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct CurrentWeatherCardView: View {
    let model: CurrentWeatherUIModel

    var body: some View {
        HStack(spacing: 20) {
            CachedAsyncImage(url: model.iconURL)
                .frame(width: 90, height: 90)
                .shadow(color: .black.opacity(0.25), radius: 10)

            VStack(alignment: .leading, spacing: 8) {
                Text(model.temperature)
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.7)

                HStack(spacing: 12) {
                    Text("H: \(model.high)")
                    Text("L: \(model.low)")
                }
                .font(.headline)
                .foregroundColor(.white.opacity(0.85))

                Text(model.feelsLikeDescription)
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
            temperature: "24°",
            condition: "Cloudy",
            feelsLikeDescription: "Feels like ",
            feelsLikeValue: "25°",
            high: "27°",
            low: "18°",
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
