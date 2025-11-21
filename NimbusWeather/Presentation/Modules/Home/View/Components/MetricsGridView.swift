//
//  MetricsGridView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct MetricsGridView: View {
    let humidity: String
    let wind: String
    let pressure: String
    let feelsLike: String

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            MetricCardView(
                title: "Humidity",
                value: humidity,
                systemIcon: "humidity.fill"
            )

            MetricCardView(
                title: "Wind",
                value: wind,
                systemIcon: "wind"
            )

            MetricCardView(
                title: "Pressure",
                value: pressure,
                systemIcon: "gauge.medium"
            )

            MetricCardView(
                title: "Feels Like",
                value: feelsLike,
                systemIcon: "thermometer.medium"
            )
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MetricsGridView(
        humidity: "60%",
        wind: "3.2 m/s",
        pressure: "1015 hPa",
        feelsLike: "Feels like 25°"
    )
    .background(
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
    )
}
