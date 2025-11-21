//
//  DailyForecastRowView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct DailyForecastRowView: View {
    let model: DailyWeatherUIModel

    var body: some View {
        HStack {
            Text(model.day)
                .font(.subheadline)
                .foregroundColor(.white)

            Spacer()

            AsyncImage(
                url: URL(string: "https://openweathermap.org/img/wn/\(model.icon)@2x.png")
            ) { img in
                img.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 32, height: 32)

            Spacer()
                .frame(width: 24)

            Text(model.minTemp)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.15))
                    .frame(height: 4)

                Capsule()
                    .fill(Color.white)
                    .frame(width: CGFloat(70), height: 4)
            }
            .frame(width: 90)

            Text(model.maxTemp)
                .font(.subheadline)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    DailyForecastRowView(
        model: DailyWeatherUIModel(
            day: "Monday",
            minTemp: "17°",
            maxTemp: "27°",
            icon: "03d"
        )
    )
    .background(
        LinearGradient(colors: [.blue, .purple],
                       startPoint: .top,
                       endPoint: .bottom)
    )
}
