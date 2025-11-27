//
//  SearchTriggerBarView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 27.11.2025.
//

import SwiftUI

struct SearchTriggerBarView: View {
    var onTapSearch: () -> Void
    var onLocationRequest: () -> Void
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                Text("Search location")
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(14)
            .onTapGesture { onTapSearch() }

            Button {
                onLocationRequest()
            } label: {
                Image(systemName: "location.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.blue)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .shadow(
            color: colorScheme == .dark
                ? Color.white.opacity(0.18)
                : Color.black.opacity(0.25),
            radius: 20,
            y: 12
        )
    }
}
#Preview {
    SearchTriggerBarView(onTapSearch: {}, onLocationRequest: {})
}
