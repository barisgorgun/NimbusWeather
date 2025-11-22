//
//  RainBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 22.11.2025.
//

import SwiftUI

struct RainBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var rotateCloud = false
    @State private var rainDrop = false

    var body: some View {
        ZStack {
            backgroundGradient
            
            Circle()
                .fill(Color.blue.opacity(0.18))
                .frame(width: 160, height: 160)
                .blur(radius: 30)

            Image(systemName: "cloud.fill")
                .font(.system(size: 90))
                .foregroundColor(.white.opacity(0.9))
                .offset(y: -10)
                .rotationEffect(.degrees(rotateCloud ? 60 : 0))
                .animation(
                    .linear(duration: 4)
                        .repeatForever(autoreverses: true),
                    value: rotateCloud
                )
                .onAppear {
                    rotateCloud = true
                }

            ForEach(0..<7) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white.opacity(0.95))
                    .frame(width: 4, height: 14)
                    .offset(x: CGFloat(i * 12 - 36), y: rainDrop ? 50 : -10)
                    .opacity(rainDrop ? 0 : 1)
                    .animation(
                        .easeIn(duration: 0.6)
                        .repeatForever()
                        .delay(Double(i) * 0.15),
                        value: rainDrop
                    )
            }
        }
        .task {
            rotateCloud = true
            rainDrop = true
        }
    }

    private var backgroundGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.07, blue: 0.12),
                    Color(red: 0.08, green: 0.10, blue: 0.16),
                    Color(red: 0.12, green: 0.13, blue: 0.20)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [
                    Color(red: 0.55, green: 0.65, blue: 0.80).opacity(0.65),
                    Color(red: 0.60, green: 0.70, blue: 0.85).opacity(0.60),
                    Color(red: 0.68, green: 0.78, blue: 0.92).opacity(0.65)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    RainBackgroundView()
}
