//
//  NightBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import SwiftUI

struct NightBackgroundView: View {
    @State private var twinkle = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.08, blue: 0.15), // deep night blue
                    Color(red: 0.12, green: 0.15, blue: 0.28)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            Circle()
                .fill(Color.white.opacity(0.25))
                .frame(width: 130, height: 130)
                .blur(radius: 20)
                .offset(x: -80, y: -160)

            Image(systemName: "moon.stars.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 70))
                .shadow(color: .white.opacity(0.6), radius: 12)
                .offset(x: -70, y: -165)

            ForEach(0..<18) { i in
                Circle()
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 3, height: 3)
                    .opacity(twinkle ? .random(in: 0.3...1) : .random(in: 0.1...0.8))
                    .position(
                        x: .random(in: 0...UIScreen.main.bounds.width),
                        y: .random(in: 0...UIScreen.main.bounds.height)
                    )
            }
            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: twinkle)
        }
        .onAppear {
            twinkle = true
        }
    }
}

#Preview {
    NightBackgroundView()
}

