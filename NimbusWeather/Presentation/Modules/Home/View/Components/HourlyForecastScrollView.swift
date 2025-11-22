//
//  HourlyForecastScrollView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct HourlyForecastScrollView: View {
    let items: [HourlyWeatherUIModel]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hourly Forecast")
                .font(.headline)
                .foregroundColor(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { hour in
                        HourlyForecastItemView(model: hour)
                    }
                }
                .padding(12)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

#Preview {
    HourlyForecastScrollView(
        items: [
            HourlyWeatherUIModel(hour: "15:00", temperature: "24", icon: "03d"),
            HourlyWeatherUIModel(hour: "16:00", temperature: "25", icon: "01d"),
            HourlyWeatherUIModel(hour: "17:00", temperature: "23", icon: "10d")
        ]
    )
    .background(
        LinearGradient(colors: [.blue, .purple],
                       startPoint: .top,
                       endPoint: .bottom)
    )
}
