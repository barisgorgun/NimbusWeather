//
//  WeatherOverviewView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 27.11.2025.
//

import SwiftUI

struct WeatherOverviewView: View {
    let uiModel: WeatherUIModel
    var showLocationButton: Bool = true
    var onLocationRequest: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {
                HomeHeaderView(
                    location: uiModel.cityName,
                    condition: uiModel.current.condition,
                    date: Date().formattedDateTimeInTimezone(uiModel.timezone),
                    onLocationRequest: onLocationRequest,
                    showLocationButton: showLocationButton
                )

                CurrentWeatherCardView(model: uiModel.current)

                MetricsGridView(
                    humidity: uiModel.current.humidity,
                    wind: uiModel.current.windSpeed,
                    pressure: uiModel.current.pressure,
                    feelsLikeValue: uiModel.current.feelsLikeValue
                )

                HourlyForecastScrollView(items: uiModel.hourly)

                DailyForecastListView(items: uiModel.daily)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    let mockWeatherUIModel = WeatherUIModel(
        cityName: "Istanbul",
        timezone: "",
        current: CurrentWeatherUIModel(
            temperature: 24,
            condition: "Partly Cloudy",
            feelsLikeValue: 25,
            high: 27,
            low: 18,
            icon: "cloud.sun.fill",
            humidity: "62%",
            windSpeed: "14 km/h",
            pressure: "1012 hPa"
        ),
        hourly: [
            HourlyWeatherUIModel(hour: "Now", temperature: 24, icon: "cloud.sun.fill"),
            HourlyWeatherUIModel(hour: "15:00", temperature: 25, icon: "sun.max.fill"),
            HourlyWeatherUIModel(hour: "16:00", temperature: 25, icon: "sun.max.fill"),
            HourlyWeatherUIModel(hour: "17:00", temperature: 23, icon: "cloud.sun.fill"),
            HourlyWeatherUIModel(hour: "18:00", temperature: 21, icon: "cloud.fill")
        ],
        daily: [
            DailyWeatherUIModel(day: "Today", minTemp: "18°", maxTemp: "27°", icon: "cloud.sun.fill"),
            DailyWeatherUIModel(day: "Wed", minTemp: "17°", maxTemp: "26°", icon: "cloud.drizzle.fill"),
            DailyWeatherUIModel(day: "Thu", minTemp: "19°", maxTemp: "29°", icon: "sun.max.fill"),
            DailyWeatherUIModel(day: "Fri", minTemp: "20°", maxTemp: "30°", icon: "sun.max.fill"),
            DailyWeatherUIModel(day: "Sat", minTemp: "18°", maxTemp: "28°", icon: "cloud.sun.fill")
        ]
    )

    WeatherOverviewView(uiModel: mockWeatherUIModel, onLocationRequest: { })
}
