//
//  JSONLoader.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import Foundation

enum JSONLoader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type) throws -> T {
        let bundle = Bundle(for: Dummy.self)
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "JSONLoader", code: 1, userInfo: [NSLocalizedDescriptionKey: "File not found: \(filename).json"])
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }

    private class Dummy {}
}
