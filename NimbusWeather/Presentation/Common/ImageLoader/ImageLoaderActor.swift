//
//  ImageLoaderActor.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

actor ImageLoaderActor {
    static let shared = ImageLoaderActor()

    private var cache: [URL: Image] = [:]

    func loadImage(from url: URL) async throws -> Image {

        if let cached = cache[url]  {
            return cached
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let uiImage = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        let image = Image(uiImage: uiImage)
        cache[url] = image
        return image
    }
}
