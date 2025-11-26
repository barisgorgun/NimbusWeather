//
//  SearchResultsListView.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import SwiftUI

struct SearchResultsListView: View {
    let items: [SearchResultUIModel]
    let onSelect: (SearchResultUIModel) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(items) { item in
                    SearchResultRowView(name: item.name, state: item.state, country: item.country) {
                        onSelect(item)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    SearchResultsListView(items: [], onSelect: { _ in })
}
