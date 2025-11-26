//
//  SearchLocationMapper.swift
//  NimbusWeatherData
//
//  Created by Gorgun, Baris on 26.11.2025.
//

import NimbusWeatherDomain

public struct SearchLocationMapper {

    public static func map(_ dto: SearchLocationDTO) -> LocationSearchResult {
        return LocationSearchResult(
            name: dto.name,
            country: dto.country,
            lat: dto.lat,
            lon: dto.lon
        )
    }
}
