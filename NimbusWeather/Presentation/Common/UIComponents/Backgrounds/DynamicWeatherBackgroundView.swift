//
//  DynamicWeatherBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 22.11.2025.
//

import SwiftUI

struct DynamicWeatherBackgroundView: View {
    let condition: String

    var body: some View {
        switch condition.toWeatherConditionType {
        case .sunny:
            SunnyBackgroundView()
        case .cloudy:
            CloudyBackgroundView()
        case .rainy:
            RainBackgroundView()
        case .snow:
            SnowBackgroundView()
        case .thunder:
            ThunderstormBackgroundView()
        case .fog:
            FogBackgroundView()
        case .unknown:
            SunnyBackgroundView()
        }
    }
}

#Preview {
    DynamicWeatherBackgroundView(condition: "snow")
}
