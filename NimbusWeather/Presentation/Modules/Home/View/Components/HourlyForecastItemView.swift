//
//  HourlyForecastItemView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct HourlyForecastItemView: View {
    let model: HourlyWeatherUIModel

    var body: some View {
        VStack(spacing: 10) {
            Text(model.hour)
                .font(.caption)
                .foregroundColor(.white.opacity(0.9))

            CachedAsyncImage(url: model.iconURL)
            .frame(width: 40, height: 40)

            Text(model.temperature)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 55)
        .padding(.vertical, 8)
    }
}

#Preview {
    HourlyForecastItemView(
        model: HourlyWeatherUIModel(
            hour: "15:00",
            temperature: "24",
            icon: "cloud.sun.fill"
        )
    )
    .background(
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
    )
}
