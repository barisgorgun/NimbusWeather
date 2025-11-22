//
//  CloudLoadingView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct CloudLoadingView: View {
    @State private var sway1 = false
    @State private var sway2 = false
    @State private var floatUpDown = false

    var body: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.12))
                .frame(width: 200, height: 200)
                .blur(radius: 40)
                .offset(y: -20)

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
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.gray.opacity(0.5), .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        CloudLoadingView()
    }
}
