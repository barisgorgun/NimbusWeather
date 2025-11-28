//
//  LocationListView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 28.11.2025.
//

import SwiftUI

struct LocationListView: View {
    let mockCities: [FavoriteCityUIModel] = [

        FavoriteCityUIModel(
            city: "Kocaeli",
            time: "16:12",
            condition: "Mostly Sunny",
            temperature: "18°",
            high: "H:19°",
            low: "L:11°",
            backgroundImage: "clear_bg"
        ),

        FavoriteCityUIModel(
            city: "Paris",
            time: "15:12",
            condition: "Thunderstorm",
            temperature: "11°",
            high: "H:13°",
            low: "L:9°",
            backgroundImage: "thunder_bg"
        ),

        FavoriteCityUIModel(
            city: "İstanbul",
            time: "16:12",
            condition: "Partly Cloudy",
            temperature: "18°",
            high: "H:19°",
            low: "L:13°",
            backgroundImage: "cloudy_bg"
        ),

        FavoriteCityUIModel(
            city: "Ankara",
            time: "16:12",
            condition: "Mostly Sunny",
            temperature: "15°",
            high: "H:15°",
            low: "L:4°",
            backgroundImage: "snow_bg"
        ),

        FavoriteCityUIModel(
            city: "Berlin",
            time: "14:12",
            condition: "Cloudy",
            temperature: "7°",
            high: "H:8°",
            low: "L:4°",
            backgroundImage: "overcast_bg"
        ),

        FavoriteCityUIModel(
            city: "Bursa",
            time: "16:12",
            condition: "Mostly Sunny",
            temperature: "18°",
            high: "H:19°",
            low: "L:11°",
            backgroundImage: "night_bg"
        ),

        FavoriteCityUIModel(
            city: "Samsun",
            time: "16:12",
            condition: "Rainy",
            temperature: "10°",
            high: "H:12°",
            low: "L:7°",
            backgroundImage: "rainy_bg"
        ),

        FavoriteCityUIModel(
            city: "İzmir",
            time: "16:12",
            condition: "Clear",
            temperature: "20°",
            high: "H:21°",
            low: "L:13°",
            backgroundImage: "sunny_bg"
        )
    ]


    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(mockCities) { city in
                        FavoriteCityCardView(model: city)
                            .onTapGesture {

                            }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
            .background(Color.black)
        }
        .navigationTitle("Weather")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    LocationListView()
}
