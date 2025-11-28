//
//  SearchTriggerBarView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 27.11.2025.
//

import SwiftUI

struct SearchTriggerBarView: View {
    var onTapSearch: () -> Void
    var listBulletClicked: () -> Void
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
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.cyan.opacity(0.35), lineWidth: 1.2)
            )
            .onTapGesture { onTapSearch() }

            Button {
                listBulletClicked()
            } label: {
                Image(systemName: "list.bullet")
                    .font(.system(size: 22, weight: .semibold))
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(.white)
                    .frame(width: 54, height: 54)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.cyan.opacity(0.35), lineWidth: 1.2)
                    )
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
    SearchTriggerBarView(onTapSearch: {}, listBulletClicked: {})
}
