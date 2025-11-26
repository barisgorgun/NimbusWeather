//
//  SearchResultRowView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import SwiftUI

struct SearchResultRowView: View {
    let name: String
    let state: String?
    let country: String
    let onSelect: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white.opacity(0.9), .white.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(color: .black.opacity(0.15), radius: 10, y: 6)

            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center, spacing: 0) {
                    Text(name)
                        .font(.title3.bold())
                        .foregroundColor(.white)

                    if let state = state {
                        Text(", \(state)")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                    }
                }

                Text(country)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.85))
            }
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.47, green: 0.72, blue: 1.0).opacity(0.8),
                    Color(red: 0.65, green: 0.52, blue: 1.0).opacity(0.8)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.25), radius: 20, y: 12)
        .onTapGesture {
            onSelect()
        }
    }
}

#Preview {
    SearchResultRowView(name: "Berlin", state: "New Hampshire", country: "Turkey", onSelect: { })
}
