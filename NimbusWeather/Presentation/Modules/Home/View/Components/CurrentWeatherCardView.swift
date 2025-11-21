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
        HStack(spacing: 12) {
            CachedAsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(model.icon)@2x.png"))
                .frame(width: 100, height: 100)

            VStack(spacing: 8) {
                Text(model.temperature)
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.white)

                HStack {
                    Text("H: \(model.high)")
                    Text("L: \(model.low)")
                }
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

                Text(model.feelsLikeDescription)
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.vertical, 16)
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
