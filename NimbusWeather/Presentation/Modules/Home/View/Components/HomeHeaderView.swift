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
    let date: String
    var onLocationRequest: () -> Void
    var showLocationButton: Bool

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .center) {
                Text(location)
                    .font(.title3.weight(.bold))
                    .foregroundColor(.white)

                if showLocationButton {
                    Button {
                        onLocationRequest()
                    } label: {
                        Image(systemName: "location.fill")
                            .font(.system(size: 8, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding(6)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
            }

            Text(condition)
                .font(.title3.weight(.medium))
                .foregroundColor(.white.opacity(0.9))

            Text(date)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

#Preview {
    HomeHeaderView(location: "Istanbul" , condition: "Partly Cloudy", date: "22:10", onLocationRequest: { }, showLocationButton: true)
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
        )
}
