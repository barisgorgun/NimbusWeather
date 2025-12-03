//
//  MockSearchUseCase.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain

final class MockSearchUseCase: SearchLocationsUseCaseProtocol {
    var jsonFileName: String?
    var shouldThrow: Bool = false
    var errorToThrow: Error = NSError(domain: "Test", code: -1)
    private(set) var isExecuted = false

    func execute(query: String) async throws -> [LocationSearchResult] {
        isExecuted = true

        if shouldThrow {
            throw errorToThrow
        }

        guard let file = jsonFileName else {
            fatalError("jsonFileName must be set before calling execute")
        }

        return try JSONLoader.load(file, as: [LocationSearchResult].self)
    }
}
