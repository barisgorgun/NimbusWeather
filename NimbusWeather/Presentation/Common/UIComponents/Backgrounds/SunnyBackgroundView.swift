//
//  SunnyBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 22.11.2025.
//

import SwiftUI

struct SunnyBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var rotation: Double = 0
    @State private var rotate = false
    @State private var pulse = false

    var body: some View {
        ZStack {
            backgroundGradient

            Circle()
                .fill(Color.yellow.opacity(0.28))
                .frame(width: 160, height: 160)
                .blur(radius: 26)
                .scaleEffect(pulse ? 1.15 : 0.95)
                .animation(
                    .easeInOut(duration: 2.2).repeatForever(autoreverses: true),
                    value: pulse
                )

            Image(systemName: "sun.max.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 90))
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .animation(
                    .linear(duration: 8).repeatForever(autoreverses: false),
                    value: rotate
                )
                .shadow(color: .yellow.opacity(0.5), radius: 10)
        }
        .task {
            rotate = true
            pulse = true
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 35).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }

    private var backgroundGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                colors: [
                    Color.yellow.opacity(0.25),
                    Color.orange.opacity(0.15),
                    Color(red: 0.98, green: 0.85, blue: 0.60).opacity(0.15)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.32, green: 0.55, blue: 0.90).opacity(0.85),
                    Color(red: 0.45, green: 0.67, blue: 0.95).opacity(0.75),
                    Color(red: 0.68, green: 0.82, blue: 0.98).opacity(0.70)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private var lightRayColor: Color {
        colorScheme == .dark ? .yellow : Color.yellow.opacity(0.6)
    }
}

#Preview {
    SunnyBackgroundView()
}
