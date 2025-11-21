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
            AsyncImage(
                         url: URL(string: "https://openweathermap.org/img/wn/\(model.icon)@2x.png")
                     ) { img in
                         img
                             .resizable()
                             .scaledToFit()
                     } placeholder: {
                         ProgressView()
                     }
                     .symbolRenderingMode(.multicolor)
                     .frame(width: 80, height: 80)

            VStack(spacing: 16) {
                Text(model.temperature)
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.white)

                HStack {
                    Text("H: \(model.high)")
                    Text("L: \(model.low)")
                }
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))

                Text("Feels like \(model.feelsLike)")
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
            feelsLike: "25°",
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
