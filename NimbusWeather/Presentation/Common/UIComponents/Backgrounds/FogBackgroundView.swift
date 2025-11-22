//
//  FogBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 23.11.2025.
//

import SwiftUI

import SwiftUI

struct FogBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var drift: CGFloat = -300
    @State private var drift2: CGFloat = 350

    var body: some View {
        ZStack {
            lightOrDarkBackground

            fogLayer(opacity: fogOpacityPrimary, blur: fogBlurPrimary)
                .offset(x: drift)
                .animation(
                    .linear(duration: 18)
                        .repeatForever(autoreverses: true),
                    value: drift
                )

            fogLayer(opacity: fogOpacitySecondary, blur: fogBlurSecondary)
                .offset(x: drift2)
                .animation(
                    .linear(duration: 24)
                        .repeatForever(autoreverses: true),
                    value: drift2
                )
        }
        .onAppear {
            drift = 320
            drift2 = -320
        }
        .ignoresSafeArea()
    }
}

extension FogBackgroundView {

    // MARK: - FOG LAYERS

    private func fogLayer(opacity: Double, blur: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(
                LinearGradient(
                    colors: [
                        fogColor.opacity(opacity),
                        fogColor.opacity(opacity * 0.6),
                        fogColor.opacity(opacity * 0.25)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 360)
            .blur(radius: blur)
            .offset(y: 40)
    }

    // MARK: - COLOR LOGIC

    private var fogColor: Color {
        colorScheme == .dark
        ? Color.white
        : Color.gray.opacity(0.75)
    }

    // MARK: - OPACITY

    private var fogOpacityPrimary: Double {
        colorScheme == .dark ? 0.32 : 0.45
    }

    private var fogOpacitySecondary: Double {
        colorScheme == .dark ? 0.22 : 0.35
    }

    private var fogBlurPrimary: CGFloat {
        colorScheme == .dark ? 40 : 30
    }

    private var fogBlurSecondary: CGFloat {
        colorScheme == .dark ? 55 : 40
    }

    // MARK: - BACKGROUND

    private var lightOrDarkBackground: some View {
        Group {
            if colorScheme == .dark {
                LinearGradient(
                    colors: [
                        Color(red: 0.10, green: 0.12, blue: 0.16),
                        Color(red: 0.05, green: 0.06, blue: 0.10)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else {
                LinearGradient(
                    colors: [
                        Color(red: 0.78, green: 0.80, blue: 0.82),
                        Color(red: 0.85, green: 0.86, blue: 0.88)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }
}

#Preview {
    FogBackgroundView()
        .frame(height: 600)
}
