//
//  DailyForecastListView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct DailyForecastListView: View {
    let items: [DailyWeatherUIModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("10-Day Forecast")
                .font(.headline)
                .foregroundColor(.white)

            VStack(spacing: 8) {
                ForEach(items) { day in
                    DailyForecastRowView(model: day)
                    if day.id != items.last?.id {
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.leading, 10)
                    }
                }
            }
            .padding(12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

#Preview {
    DailyForecastListView(
        items: [
            DailyWeatherUIModel(day: "Monday", minTemp: "17°", maxTemp: "27°", icon: "03d"),
            DailyWeatherUIModel(day: "Tuesday", minTemp: "19°", maxTemp: "30°", icon: "10d"),
            DailyWeatherUIModel(day: "Wednesday", minTemp: "18°", maxTemp: "29°", icon: "01d")
        ]
    )
    .background(
        LinearGradient(colors: [.blue, .purple],
                       startPoint: .top,
                       endPoint: .bottom)
    )
}
