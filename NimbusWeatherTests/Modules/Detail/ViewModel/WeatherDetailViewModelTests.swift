//
//  WeatherDetailViewModelTests.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import XCTest
@testable import NimbusWeather
@testable import NimbusWeatherDomain

@MainActor
final class WeatherDetailViewModelTests: XCTestCase {
    private var weatherUseCase: MockWeatherUseCase!
    private var locationService: MockLocationService!
    private var favoriteCityUseCase: MockAddFavoriteCityUseCase!
    private var viewModel: WeatherDetailViewModel!

    override func setUp() async throws {
        try await super.setUp()
        weatherUseCase = MockWeatherUseCase()
        locationService = MockLocationService()
        favoriteCityUseCase = MockAddFavoriteCityUseCase()
        viewModel = WeatherDetailViewModel(
            weatherUseCase: weatherUseCase,
            locationService: locationService,
            addFavoriteCityUseCase: favoriteCityUseCase,
            lat: 41.0,
            lon: 29.0
        )
    }

    override func tearDown() async throws {
        weatherUseCase = nil
        locationService = nil
        favoriteCityUseCase = nil
        viewModel = nil
        try await super.tearDown()
    }

    func test_fetchWeather_success_setsLoadedStateAndUIModel() async throws {
        // Given
        weatherUseCase.jsonFileName = "weather_response"
        locationService.resolvedCityName = "Kadıköy"

        // When
        await viewModel.fetchWeather()

        // Then
        switch viewModel.state {
        case .loaded(let uiModel):

            XCTAssertEqual(uiModel.cityName, "Kadıköy")
            XCTAssertEqual(uiModel.current.condition, "Clear")
            XCTAssertEqual(uiModel.hourly.count, 2)
            XCTAssertEqual(uiModel.daily.count, 2)
            XCTAssertEqual(viewModel.currentCondition, "Clear")
            XCTAssertEqual(uiModel.hourly.first?.temperature, 14.2)
            XCTAssertEqual(uiModel.hourly.first?.icon, "02d")
            XCTAssertEqual(uiModel.daily.first?.minTemp, "8°")
            XCTAssertEqual(uiModel.daily.first?.maxTemp, "17°")
            XCTAssertEqual(uiModel.daily.first?.icon, "10d")

        default:
            XCTFail("Expected loaded state but got \(viewModel.state)")
        }
    }

    func test_fetchWeather_failure_setsErrorState() async throws {
        // Given
        weatherUseCase.shouldThrow = true
        weatherUseCase.errorToThrow = NSError(domain: "Test", code: -1)

        // When
        await viewModel.fetchWeather()

        // Then
        switch viewModel.state {
        case .error(let message):
            XCTAssertEqual(message, "Veri alınamadı")
        default:
            XCTFail("Expected .error state but got \(viewModel.state)")
        }
    }

    func test_addFavoriteCity_success_setsSuccessFlag() async throws {
        // Given
        locationService.resolvedCityName = "Kadıköy"

        weatherUseCase.jsonFileName = "weather_response"
        await viewModel.fetchWeather()

        // When
        await viewModel.addFavoriteCity()

        // Then
        XCTAssertTrue(viewModel.isAddSuccess)

        let executed = favoriteCityUseCase.executedCity
        XCTAssertNotNil(executed)

        XCTAssertEqual(executed?.name, "Kadıköy")
    }

    func test_addFavoriteCity_failure_doesNotSetSuccessFlag() async throws {
        // Given
        weatherUseCase.jsonFileName = "weather_response"
        locationService.resolvedCityName = "Kadıköy"

        await viewModel.fetchWeather()

        favoriteCityUseCase.shouldThrow = true

        // When
        await viewModel.addFavoriteCity()

        // Then
        XCTAssertFalse(viewModel.isAddSuccess)
        XCTAssertNotNil(favoriteCityUseCase.executedCity)
        XCTAssertEqual(favoriteCityUseCase.executedCity?.name, "Kadıköy")
    }


}
