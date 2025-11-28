//
//  ToolbarCircleButton.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 28.11.2025.
//

import SwiftUI

struct ToolbarCircleButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .symbolRenderingMode(.hierarchical)
        }
    }
}

#Preview {
    ToolbarCircleButton(systemName: "xmark", action: { })
}
