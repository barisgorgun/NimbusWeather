//
//  SharedBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 30.11.2025.
//

import SwiftUI

struct SharedBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        LinearGradient(
            colors: backgroundColors,
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var backgroundColors: [Color] {
        if colorScheme == .dark {
            return [
                Color("WeatherBackgroundDarkStart"),
                Color("WeatherBackgroundDarkEnd")
            ]
        } else {
            return [
                Color("WeatherBackgroundLightStart"),
                Color("WeatherBackgroundLightMiddle"),
                Color("WeatherBackgroundLightEnd")
            ]
        }
    }
}

#Preview {
    SharedBackgroundView()
}
