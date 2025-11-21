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

            AsyncImage(
                url: URL(string: "https://openweathermap.org/img/wn/\(model.icon)@2x.png")
            ) { img in
                img
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 36, height: 36)

            HStack {
                Text(model.minTemp)
                    .foregroundColor(.white.opacity(0.8))
                    .font(.system(size: 14))

                GeometryReader { geo in
                    let barWidth = geo.size.width

                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(.white.opacity(0.25))

                        Capsule()
                            .fill(.white.opacity(0.8))
                            .frame(width: barWidth * model.rangeRatio)
                    }
                }
                .frame(height: 6)

                Text(model.maxTemp)
                    .foregroundColor(.white.opacity(0.9))
                    .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity)
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
