//
//  DynamicWeatherLoadingView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct DynamicWeatherLoadingView: View {
    let condition: String

    var body: some View {
        switch condition.lowercased() {
        case "rain":
            RainLoadingView()
        case "clouds":
            CloudLoadingView()
        case "clear":
            SunnyLoadingView()
        case "snow":
            SnowLoadingView()
        default:
            WeatherLoadingView()
        }
    }
}

#Preview {
    DynamicWeatherLoadingView(condition: "")
}
