//
//  WindSpinnerLoadingView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import SwiftUI

struct WindSpinnerLoadingView: View {
    @State private var rotate = false

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.75)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color.cyan.opacity(0.0),
                            Color.cyan.opacity(0.4),
                            Color.cyan.opacity(0.7)
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: 52, height: 52)
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .animation(
                    .linear(duration: 1.0).repeatForever(autoreverses: false),
                    value: rotate
                )
        }
        .onAppear { rotate = true }
    }
}

#Preview {
    WindSpinnerLoadingView()
}
