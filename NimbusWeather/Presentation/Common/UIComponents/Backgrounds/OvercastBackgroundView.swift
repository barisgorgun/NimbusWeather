//
//  OvercastBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import SwiftUI

struct OvercastBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var driftClouds = false

    var body: some View {
        ZStack {
            gradientBackground

            // Layered cloud system
            ForEach(0..<4) { i in
                RoundedRectangle(cornerRadius: 200)
                    .fill(Color.white.opacity(0.15 + Double(i) * 0.05))
                    .frame(width: 400 - CGFloat(i * 40),
                           height: 180 - CGFloat(i * 20))
                    .blur(radius: 30 - CGFloat(i * 4))
                    .offset(
                        x: driftClouds ? CGFloat(20 + i * 8) : CGFloat(-20 - i * 8),
                        y: CGFloat(-100 + i * 40)
                    )
                    .animation(
                        .easeInOut(duration: 5 + Double(i))
                        .repeatForever(autoreverses: true),
                        value: driftClouds
                    )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            driftClouds = true
        }
    }

    private var gradientBackground: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                colors: [
                    Color(red: 0.07, green: 0.08, blue: 0.13),
                    Color(red: 0.10, green: 0.11, blue: 0.17),
                    Color(red: 0.12, green: 0.13, blue: 0.20)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.75, green: 0.78, blue: 0.85),
                    Color(red: 0.80, green: 0.83, blue: 0.90),
                    Color(red: 0.85, green: 0.88, blue: 0.93)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    OvercastBackgroundView()
}
