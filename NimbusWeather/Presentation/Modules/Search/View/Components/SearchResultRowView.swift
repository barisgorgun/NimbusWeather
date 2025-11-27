//
//  SearchResultRowView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import SwiftUI

struct SearchResultRowView: View {
    let result: SearchResultUIModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center) {
                Text(result.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                if let state = result.state {
                    Text(", \(state)")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                }
            }

            Text(result.country)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 10)
        .padding(.horizontal, 4)
        .background(Color.clear)
        .overlay(
            Rectangle()
                .fill(Color.white.opacity(0.12))
                .frame(height: 0.5),
            alignment: .bottom
        )
    }
}


#Preview {
    SearchResultRowView(result: SearchResultUIModel(name: "Darica", country: "Tr", lat: 20.121, lon: 32.123, state: nil))
}
