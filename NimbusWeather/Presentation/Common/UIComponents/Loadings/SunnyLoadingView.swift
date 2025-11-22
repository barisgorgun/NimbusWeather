//
//  SunnyLoadingView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct SunnyLoadingView: View {
    @State private var rotate = false
    @State private var pulse = false


    var body: some View {
        ZStack {
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
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

        SunnyLoadingView()
    }
}
