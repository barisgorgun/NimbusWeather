//
//  ImageLoaderActor.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import SwiftUI

protocol ImageLoadingSession {
    func load(from url: URL) async throws -> Data
}

actor ImageLoaderActor {
    static let shared = ImageLoaderActor()
    private var cache: [URL: Image] = [:]
    private var tasks: [URL: Task<Image, Error>] = [:]
    private let session: ImageLoadingSession

    init(session: ImageLoadingSession = URLSessionLoader()) {
        self.session = session
    }

    func loadImage(from url: URL) async throws -> Image {

        if let cached = cache[url] {
            return cached
        }

        if let existingTask = tasks[url] {
            return try await existingTask.value
        }

        let task = Task { () -> Image in
            defer {
                tasks[url] = nil
            }

            let data = try await session.load(from: url)

            guard let uiImage = UIImage(data: data) else {
                throw URLError(.cannotDecodeContentData)
            }

            let image = Image(uiImage: uiImage)
            cache[url] = image
            return image
        }

        tasks[url] = task
        return try await task.value
    }
}

struct URLSessionLoader: ImageLoadingSession {
    func load(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
