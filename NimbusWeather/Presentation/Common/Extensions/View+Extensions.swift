//
//  View+Extensions.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 27.11.2025.
//

import Foundation
import SwiftUI

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
