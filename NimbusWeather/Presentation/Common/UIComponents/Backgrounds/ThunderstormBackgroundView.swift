//
//  ThunderstormBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 23.11.2025.
//

import SwiftUI

struct ThunderstormBackgroundView: View {
    @State private var lightningOpacity: Double = 0
    @State private var lightningOffset: CGFloat = 0
    @State private var rainDrops: [RainDrop] = []

    var body: some View {
        ZStack {
            stormBackground

            RainLayer(drops: rainDrops)

            lightningFlash
        }
        .ignoresSafeArea()
        .task {
            generateRain()
            startLightningLoop()
        }
    }
}

extension ThunderstormBackgroundView {
    private var stormBackground: some View {
        LinearGradient(
            colors: [
                Color(red: 0.05, green: 0.06, blue: 0.10),
                Color(red: 0.00, green: 0.00, blue: 0.03)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

extension ThunderstormBackgroundView {
    private var lightningFlash: some View {
        ZStack {
            Color.white
                .opacity(lightningOpacity)
                .blendMode(.plusLighter)

            Rectangle()
                .fill(Color.white.opacity(lightningOpacity * 0.9))
                .frame(width: 3)
                .offset(x: lightningOffset)
                .blur(radius: 2)
                .blendMode(.plusLighter)
        }
        .allowsHitTesting(false)
        .animation(.easeOut(duration: 0.2), value: lightningOpacity)
    }

    private func startLightningLoop() {
        Task {
            while true {
                let wait = Double.random(in: 2.5...5.5)
                try? await Task.sleep(for: .seconds(wait))
                triggerLightning()
            }
        }
    }

    private func triggerLightning() {
        lightningOffset = CGFloat.random(in: -180...180)
        lightningOpacity = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            lightningOpacity = 0
        }
    }
}

extension ThunderstormBackgroundView {
    private func generateRain() {
        rainDrops = (0..<140).map { _ in
            RainDrop(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                len: CGFloat.random(in: 8...14),
                speed: Double.random(in: 0.35...0.55)
            )
        }
    }
}

struct RainDrop: Identifiable {
    let id = UUID()
    let x: CGFloat
    let len: CGFloat
    let speed: Double
}

struct RainLayer: View {
    let drops: [RainDrop]

    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate

            Canvas { context, size in
                for drop in drops {
                    let travel = drop.speed * now * 350
                    let y = (travel
                            .truncatingRemainder(dividingBy: size.height + 200)) - 200

                    var path = Path()
                    path.move(to: CGPoint(x: drop.x, y: y))
                    path.addLine(to: CGPoint(x: drop.x,
                                             y: y + drop.len))

                    context.stroke(
                        path,
                        with: .color(Color.white.opacity(0.45)),
                        style: StrokeStyle(lineWidth: 1, lineCap: .round)
                    )
                }
            }
        }
        .ignoresSafeArea()
    }
}
