//
//  WeatherLoadingView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct WeatherLoadingView: View {
    @State private var rotateCloud = false
    @State private var sway = false
    @State private var rainDrop = false

    var body: some View {
        VStack(spacing: 24) {

            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 160, height: 160)
                    .blur(radius: 20)

                Image(systemName: "cloud.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white.opacity(0.9))
                    .rotationEffect(.degrees(rotateCloud ? 360 : 0))
                    .animation(
                        .linear(duration: 8).repeatForever(autoreverses: false),
                        value: rotateCloud
                    )
                    .offset(x: sway ? 8 : -8, y: 0)
                    .animation(
                        .easeInOut(duration: 2).repeatForever(autoreverses: true),
                        value: sway
                    )

                ForEach(0..<6) { i in
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 6, height: 12)
                        .offset(x: CGFloat(i * 12 - 30), y: rainDrop ? 60 : 10)
                        .opacity(rainDrop ? 0 : 1)
                        .animation(
                            .easeOut(duration: 0.7)
                                .repeatForever()
                                .delay(Double(i) * 0.15),
                            value: rainDrop
                        )
                }
            }

            Text("Updating Weather…")
                .font(.nwHeadline)
                .foregroundColor(.white.opacity(0.8))
                .padding(.top, 6)
        }
        .task {
            rotateCloud = true
            sway = true
            rainDrop = true
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        WeatherLoadingView()
    }
}
