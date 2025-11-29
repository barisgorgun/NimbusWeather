//
//  FavoriteCityCardView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 28.11.2025.
//

import SwiftUI

struct FavoriteCityCardView: View {
    @AppStorage("unit") private var unit: TemperatureUnit = .celsius
    let model: FavoriteCityUIModel

    var body: some View {
        ZStack {
            // MARK: - Background Image

            Image(model.backgroundImage)
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 24))

            // MARK: - Content

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(model.city)
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)

                    Text(model.time)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))

                    Text(model.condition)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.white.opacity(0.9))
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text(model.temperature.formattedTemperature(unit: unit))
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundColor(.white)

                    HStack(spacing: 8) {
                        Text("H:\(model.high.formattedTemperature(unit: unit))")
                            .foregroundColor(.white.opacity(0.9))
                            .font(.subheadline)

                        Text("L:\(model.low.formattedTemperature(unit: unit))")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.subheadline)
                    }
                }
            }
            .padding(20)
        }
        .frame(height: 110)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.2), radius: 16, y: 8)
    }
}

#Preview {
    let mock = FavoriteCityUIModel(
        id: UUID(),
        lat: 10,
        lon: 20,
        city: "Kocaeli",
        time: "16:12",
        condition: "Mostly Sunny",
        temperature: 18,
        high: 19,
        low: 11,
        backgroundImage: "cloudyBackground"
    )

    FavoriteCityCardView(model: mock)
        .padding()
}
