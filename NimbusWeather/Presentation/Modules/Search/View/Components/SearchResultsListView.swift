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
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                    Button {
                        onSelect(item)
                    } label: {
                        SearchResultRowView(result: item)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    SearchResultsListView(items: [], onSelect: { _ in })
}
