//
//  HomeHeaderView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct HomeHeaderView: View {
    let location: String
    let condition: String
    let date: Date

    var body: some View {
        VStack(spacing: 8) {
            Text(location)
                .font(.title3.weight(.bold))
                .foregroundColor(.white)

            Text(condition)
                .font(.title3.weight(.medium))
                .foregroundColor(.white.opacity(0.9))

            Text(date.formattedDateTime)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

#Preview {
    HomeHeaderView(location: "Istanbul" , condition: "Partly Cloudy", date: Date())
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
        )
}
