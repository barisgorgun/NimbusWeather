//
//  WeatherErrorView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct WeatherErrorView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.25))
                    .frame(width: 90, height: 90)
                    .blur(radius: 6)

                Image(systemName: "cloud.bolt.rain.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 50))
            }

            Text(message)
                .font(.nwHeadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Button(action: retryAction) {
                Text("Try Again")
                    .font(.nwBody)
                    .foregroundColor(.black)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 12)
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(radius: 4)
            }
        }
        .padding(24)
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

        WeatherErrorView(message: "Unable to load weather data") { }
    }
}
