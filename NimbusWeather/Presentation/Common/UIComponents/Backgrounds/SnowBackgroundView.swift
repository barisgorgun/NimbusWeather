//
//  SnowBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 22.11.2025.
//

import SwiftUI

struct SnowBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var snowflakes: [Snowflake] = []

    private let snowflakeCount = 35

    var body: some View {
        ZStack {
            backgroundGradient

            ForEach(snowflakes) { flake in
                Circle()
                    .fill(Color.white.opacity(colorScheme == .dark ? 0.85 : 0.55))
                    .frame(width: flake.size, height: flake.size)
                    .position(x: flake.x, y: flake.y)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            generateSnowflakes()
            animateSnowfall()
        }
    }

    private var backgroundGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                colors: [
                    Color(red: 0.12, green: 0.14, blue: 0.22),
                    Color(red: 0.05, green: 0.06, blue: 0.15)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.58, green: 0.70, blue: 0.85),
                    Color(red: 0.70, green: 0.80, blue: 0.92),
                    Color(red: 0.82, green: 0.88, blue: 0.96)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func generateSnowflakes() {
        let screen = UIScreen.main.bounds

        snowflakes = (0..<snowflakeCount).map { _ in
            Snowflake(
                x: CGFloat.random(in: 0...screen.width),
                y: CGFloat.random(in: -300...screen.height),
                size: CGFloat.random(in: 2...6),
                speed: CGFloat.random(in: 2...7),
                drift: CGFloat.random(in: -1.2...1.2)
            )
        }
    }

    private func animateSnowfall() {
        let screenHeight = UIScreen.main.bounds.height

        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            for i in snowflakes.indices {
                snowflakes[i].y += snowflakes[i].speed
                snowflakes[i].x += snowflakes[i].drift

                if snowflakes[i].y > screenHeight + 50 {
                    snowflakes[i].y = CGFloat.random(in: -200...(-10))
                    snowflakes[i].x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
                }
            }
        }
    }
}

struct Snowflake: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
    var drift: CGFloat
}



#Preview {
    SnowBackgroundView()
}
