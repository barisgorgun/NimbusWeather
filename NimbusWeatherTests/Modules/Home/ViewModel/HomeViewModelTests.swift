//
//  HomeViewModelTests.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import XCTest
import CoreLocation
@testable import NimbusWeather

@MainActor
final class HomeViewModelTests: XCTestCase {
    private var locationProvider: MockUserLocationProvider!
    private var locationService: MockLocationService!
    private var weatherUseCase: MockWeatherUseCase!
    private var viewModel: HomeViewModel!

    override func setUp() async throws {
        try await super.setUp()
        locationProvider = MockUserLocationProvider()
        locationService = MockLocationService()
        weatherUseCase = MockWeatherUseCase()
        viewModel = HomeViewModel(
            weatherUseCase: weatherUseCase,
            locationService: locationService,
            locationProvider: locationProvider
        )
    }

    override func tearDown() async throws {
        locationProvider = nil
        locationService = nil
        weatherUseCase = nil
        viewModel = nil
        try await super.tearDown()
    }

    func test_fetchWeather_success_updatesStateToLoaded() async throws {
        // Given
        weatherUseCase.jsonFileName = "weather_response"
        locationService.resolvedCityName = "Istanbul"

        // When
        await viewModel.fetchWeather(lat: 41.0, lon: 29.0)

        // Then
        switch viewModel.state {
        case .loaded(let uiModel):
            XCTAssertEqual(uiModel.cityName, "Istanbul")
            XCTAssertEqual(viewModel.currentCondition, "Clear")
            XCTAssertFalse(uiModel.hourly.isEmpty)
            XCTAssertFalse(uiModel.daily.isEmpty)

        default:
            XCTFail("Expected .loaded state but got \(viewModel.state)")
        }

        XCTAssertEqual(weatherUseCase.receivedLat, 41.0)
        XCTAssertEqual(weatherUseCase.receivedLon, 29.0)
    }

    func test_fetchWeather_failure_setsErrorState() async throws {
        // Given
        weatherUseCase.shouldThrow = true
        weatherUseCase.errorToThrow = NSError(domain: "Test", code: -1)

        // When
        await viewModel.fetchWeather(lat: 10.0, lon: 20.0)

        // Then
        switch viewModel.state {
        case .error(let message):
            XCTAssertEqual(message, "Veri alınamadı")
        default:
            XCTFail("Expected error state but got \(viewModel.state)")
        }
    }

    func test_fetchWeatherForUserLocation_success_updatesStateToLoaded() async throws {
        // Given
        weatherUseCase.jsonFileName = "weather_response"
        locationProvider.mockLocation = CLLocationCoordinate2D(latitude: 41.0, longitude: 29.0)
        locationService.resolvedCityName = "Istanbul"

        // When
        await viewModel.fetchWeatherForUserLocation()

        // Then
        switch viewModel.state {
        case .loaded(let uiModel):
            XCTAssertEqual(uiModel.cityName, "Istanbul")
            XCTAssertEqual(uiModel.current.condition, "Clear")
            XCTAssertEqual(uiModel.hourly.count, 2)
            XCTAssertEqual(uiModel.daily.count, 2)
        default:
            XCTFail("Expected loaded state but got \(viewModel.state)")
        }
    }

    func test_fetchWeatherForUserLocation_locationFailure_setsErrorState() async {
        // Given
        locationProvider.shouldThrow = true
        locationProvider.errorToThrow = NSError(domain: "Location", code: 404)

        // When
        await viewModel.fetchWeatherForUserLocation()

        // Then
        switch viewModel.state {
        case .error(let message):
            XCTAssertEqual(message, "Konum alınamadı")
        default:
            XCTFail("Expected error state but got \(viewModel.state)")
        }
    }
}
