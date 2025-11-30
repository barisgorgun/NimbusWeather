//
//  PartlyCloudyBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import SwiftUI

struct PartlyCloudyBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var floatCloud = false
    @State private var rotateSun = false

    var body: some View {
        ZStack {
            gradientBackground
            Circle()
                .fill(Color.yellow.opacity(0.25))
                .frame(width: 180, height: 180)
                .blur(radius: 40)
                .offset(x: -80, y: -120)

            Image(systemName: "sun.max.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 120))
                .rotationEffect(.degrees(rotateSun ? 360 : 0))
                .animation(
                    .linear(duration: 25).repeatForever(autoreverses: false),
                    value: rotateSun
                )
                .offset(x: -60, y: -140)

            Image(systemName: "cloud.fill")
                .font(.system(size: 140))
                .foregroundColor(.white.opacity(0.85))
                .offset(y: -20)
                .offset(x: floatCloud ? -12 : 12)
                .animation(
                    .easeInOut(duration: 4).repeatForever(autoreverses: true),
                    value: floatCloud
                )
        }
        .ignoresSafeArea()
        .onAppear {
            rotateSun = true
            floatCloud = true
        }
    }

    private var gradientBackground: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                colors: [
                    Color(red: 0.07, green: 0.08, blue: 0.15),
                    Color(red: 0.10, green: 0.11, blue: 0.18),
                    Color(red: 0.13, green: 0.14, blue: 0.22)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.65, green: 0.78, blue: 0.92),
                    Color(red: 0.75, green: 0.85, blue: 0.96),
                    Color(red: 0.85, green: 0.90, blue: 0.98)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    PartlyCloudyBackgroundView()
}
