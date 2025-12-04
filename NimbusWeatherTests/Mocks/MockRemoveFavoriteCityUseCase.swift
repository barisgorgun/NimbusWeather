//
//  MockRemoveFavoriteCityUseCase.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import Foundation
@testable import NimbusWeatherDomain

final class MockRemoveFavoriteCityUseCase: RemoveFavoriteCityUseCaseProtocol {
    var executedIds: [UUID] = []
    var shouldThrow = false

    func execute(_ id: UUID) async throws {
        executedIds.append(id)
        if shouldThrow {
            throw NSError(domain: "Test", code: -1)
        }
    }
}
