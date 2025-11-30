//
//  DynamicWeatherBackgroundView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 22.11.2025.
//

import SwiftUI

struct DynamicWeatherBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var isNightNow: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 19 || hour <= 6
    }

    let condition: String

    var body: some View {
        switch condition.toWeatherConditionType {

        case .sunny:
            if colorScheme == .dark || isNightNow {
                NightBackgroundView()
            } else {
                SunnyBackgroundView()
            }
        case .cloudy:
            CloudyBackgroundView()
        case .partlyCloudy:
            PartlyCloudyBackgroundView()
        case .overcast:
            OvercastBackgroundView()
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
    DynamicWeatherBackgroundView(condition: "fog")
}
