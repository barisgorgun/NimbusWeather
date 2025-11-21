//
//  MetricsGridView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct MetricCardView: View {
    let title: String
    let value: String
    let systemIcon: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemIcon)
                .foregroundColor(.white.opacity(0.9))
                .font(.system(size: 20, weight: .medium))
                .background(.white.opacity(0.15))
                .frame(width: 32, height: 32)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))

                Text(value)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

#Preview {
    MetricCardView(title: "Feels Like", value: "Feels like 25°", systemIcon: "thermometer.medium")
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
        )
}
