//
//  JSONLoader.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 2.12.2025.
//

import Foundation

enum JSONLoader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type) throws -> T {
        let bundle = Bundle.module

        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "JSONLoader", code: 1, userInfo: [NSLocalizedDescriptionKey: "File not found: \(filename).json"])
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
