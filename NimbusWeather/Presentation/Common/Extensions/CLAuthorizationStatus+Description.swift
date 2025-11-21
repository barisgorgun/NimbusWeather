//
//  CLAuthorizationStatus+Description.swift
//  NimbusWeather
//
//  Created by Gorgun, Baris on 21.11.2025.
//

import CoreLocation

extension CLAuthorizationStatus {
    var description: String {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            "Allowed"
        case .denied:
            "Denied"
        case .restricted:
            "Restricted"
        default:
            "Not Determined"
        }
    }
}
