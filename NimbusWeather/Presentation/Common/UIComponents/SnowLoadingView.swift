//
//  SnowLoadingView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct SnowLoadingView: View {
    @State private var start = false


    var body: some View {
        ZStack {

            Circle()
                .fill(Color.white.opacity(0.15))
                .frame(width: 220, height: 220)
                .blur(radius: 40)
                .offset(y: -20)

            ForEach(0..<14) { i in
                SnowflakeRow(index: i)
            }
        }
        .task {
            start = true
        }
    }

    private struct SnowflakeRow: View {
        let index: Int
        @State private var fall = false
        @State private var drift = false

        var body: some View {
            let delay = Double(index) * 0.15
            let size = CGFloat(Int.random(in: 6...14))

            return Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: size, height: size)
                .offset(
                    x: drift ? CGFloat.random(in: -40...40) : CGFloat.random(in: -10...10),
                    y: fall ? 120 : -120
                )
                .opacity(fall ? 0.2 : 0.9)
                .animation(
                    .easeInOut(duration: Double.random(in: 3.5...5.5))
                    .repeatForever(autoreverses: false)
                    .delay(delay),
                    value: fall
                )
                .animation(
                    .easeInOut(duration: Double.random(in: 2.0...3.5))
                    .repeatForever(autoreverses: true)
                    .delay(delay),
                    value: drift
                )
                .onAppear {
                    fall = true
                    drift = true
                }
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.blue.opacity(0.5), .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        SnowLoadingView()
    }
}
