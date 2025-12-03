//
//  UserDefaultsContainer.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 3.12.2025.
//

import Foundation

public final class UserDefaultsContainer: @unchecked Sendable {
    let instance: UserDefaults

    public init(_ instance: UserDefaults) {
        self.instance = instance
    }
}
