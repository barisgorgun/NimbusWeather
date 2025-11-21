//
//  RainLoadingView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct RainLoadingView: View {
    @State private var rotateCloud = false
    @State private var rainDrop = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.18))
                .frame(width: 160, height: 160)
                .blur(radius: 30)

            Image(systemName: "cloud.fill")
                .font(.system(size: 90))
                .foregroundColor(.white.opacity(0.9))
                .offset(y: -10)
                .rotationEffect(.degrees(rotateCloud ? 360 : 0))
                .animation(
                    .linear(duration: 16)
                    .repeatForever(autoreverses: false),
                    value: rotateCloud
                )

            ForEach(0..<7) { i in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white.opacity(0.85))
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
}

#Preview {
    ZStack {
        LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        RainLoadingView()
    }
}
