//
//  MetricsGridView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct MetricsGridView: View {
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius

    let humidity: String
    let wind: String
    let pressure: String
    let feelsLikeValue: Double

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
                value: feelsLikeValue.formattedTemperature(unit: unit),
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
        feelsLikeValue: 25.0
    )
    .background(
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
    )
}
