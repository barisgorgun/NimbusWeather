//
//  CachedAsyncImage.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    let placeholder: AnyView?
    @State private var loadedImage: Image?

    init(url: URL?, @ViewBuilder placeholder: () -> AnyView? = { nil }) {
        self.url = url
        self.placeholder = placeholder()
    }

    var body: some View {
        ZStack {
            if let image = loadedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .transition(.opacity)
            } else {
                placeholder ?? AnyView(ProgressView())
            }
        }
        .task {
            await load()
        }
    }

    private func load() async {
        guard let url else {
            return
        }

        do {
            let image = try await ImageLoaderActor.shared.loadImage(from: url)
            loadedImage = image
        } catch {
            print("Image load error: \(error)")
        }
    }
}
