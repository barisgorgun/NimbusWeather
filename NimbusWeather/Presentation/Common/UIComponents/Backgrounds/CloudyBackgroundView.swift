//
//  CloudyBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 22.11.2025.
//

import SwiftUI

struct CloudyBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var sway1 = false
    @State private var sway2 = false
    @State private var floatUpDown = false

    var body: some View {
        ZStack {
            backgroundGradient

            Image(systemName: "cloud.fill")
                .font(.system(size: 120))
                .foregroundColor(.white.opacity(0.6))
                .offset(x: sway1 ? -20 : 20, y: floatUpDown ? 5 : -5)
                .scaleEffect(1.1)
                .animation(
                    .easeInOut(duration: 4.5)
                    .repeatForever(autoreverses: true),
                    value: sway1
                )
                .animation(
                    .easeInOut(duration: 5.0)
                    .repeatForever(autoreverses: true),
                    value: floatUpDown
                )

            Image(systemName: "cloud.fill")
                .font(.system(size: 90))
                .foregroundColor(.white.opacity(0.9))
                .offset(x: sway2 ? 25 : -25, y: floatUpDown ? -5 : 5)
                .animation(
                    .easeInOut(duration: 3.2)
                    .repeatForever(autoreverses: true),
                    value: sway2
                )
        }
        .task {
            sway1 = true
            sway2 = true
            floatUpDown = true
        }
        .ignoresSafeArea()
    }

    private var backgroundGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                colors: [
                    Color(red: 0.07, green: 0.08, blue: 0.12),
                    Color(red: 0.10, green: 0.11, blue: 0.18)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.52, green: 0.67, blue: 0.88),
                    Color(red: 0.60, green: 0.75, blue: 0.92),
                    Color(red: 0.68, green: 0.82, blue: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    CloudyBackgroundView()
}
