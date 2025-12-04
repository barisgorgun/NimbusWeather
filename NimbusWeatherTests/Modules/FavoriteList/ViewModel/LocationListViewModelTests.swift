//
//  LocationListViewModelTests.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import XCTest
@testable import NimbusWeather
@testable import NimbusWeatherDomain

@MainActor
final class LocationListViewModelTests: XCTestCase {
    private var loadUseCase: MockLoadFavoriteCitiesWeatherUseCase!
    private var removeUseCase: MockRemoveFavoriteCityUseCase!
    private var viewModel: LocationListViewModel!

    override func setUp() async throws {
        try await super.setUp()
        loadUseCase = MockLoadFavoriteCitiesWeatherUseCase()
        removeUseCase = MockRemoveFavoriteCityUseCase()
        viewModel = LocationListViewModel(
            removeFavoriteUseCase: removeUseCase,
            loadFavoriteCitiesWeather: loadUseCase
        )
    }

    override func tearDown() async throws {
        loadUseCase = nil
        removeUseCase = nil
        viewModel = nil
        try await super.tearDown()
    }

    func test_load_success_setsLoadedState_andMapsModelsCorrectly() async throws {
        // Given
        let sample = makeSampleFavoriteCityWeather()
            loadUseCase.result = .success([sample])

        // When
        await viewModel.load()

        // Then
        switch viewModel.state {
        case .loaded(let items):
            XCTAssertEqual(items.count, 1)

            let ui = items.first!

            XCTAssertEqual(ui.city, "Istanbul")
            XCTAssertEqual(ui.lat, 41.01, accuracy: 0.001)
            XCTAssertEqual(ui.lon, 28.97, accuracy: 0.001)
            XCTAssertEqual(ui.condition, "Clouds")
            XCTAssertEqual(ui.temperature, 12.3)
            XCTAssertEqual(ui.high, 12.3)
            XCTAssertEqual(ui.low, 12.3)
            XCTAssertFalse(ui.backgroundImage.isEmpty)
            XCTAssertFalse(ui.time.isEmpty)

        default:
            XCTFail("Expected .loaded state but got \(viewModel.state)")
        }
    }

    func test_load_success_emptyList_setsEmptyState() async {
        // Given
        loadUseCase.result = .success([])

        // When
        await viewModel.load()

        // Then
        switch viewModel.state {
        case .empty:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected .empty state but got \(viewModel.state)")
        }
    }

    func test_load_failure_setsErrorState() async {
        // Given
        loadUseCase.result = .failure(NSError(domain: "Test", code: -1))

        // When
        await viewModel.load()

        // Then
        switch viewModel.state {
        case .error(let message):
            XCTAssertFalse(message.isEmpty)
        default:
            XCTFail("Expected .error state but got \(viewModel.state)")
        }
    }

    func test_removeFavorite_callsUseCaseAndRemovesItem() async throws {
        // Given
        let sample = makeSampleFavoriteCityWeather()
        loadUseCase.result = .success([sample])
        await viewModel.load()

        let uiBefore = try XCTUnwrap((viewModel.state.loadedList))

        XCTAssertEqual(uiBefore.count, 1)

        // When
        await viewModel.removeFavorite(at: IndexSet(integer: 0))

        // Then
        XCTAssertEqual(removeUseCase.executedIds.count, 1)
        XCTAssertEqual(removeUseCase.executedIds.first, sample.city.id)

        let currentList = viewModel.state.loadedList ?? []
        XCTAssertTrue(currentList.isEmpty)
    }

    func test_removeFavorite_whenUseCaseFails_stillRemovesItemLocally() async throws {
        // Given
        let sample = makeSampleFavoriteCityWeather()
        loadUseCase.result = .success([sample])
        await viewModel.load()

        removeUseCase.shouldThrow = true

        // When
        await viewModel.removeFavorite(at: IndexSet(integer: 0))

        // Then
        let list = viewModel.state.loadedList ?? []
        XCTAssertTrue(list.isEmpty)

        XCTAssertEqual(removeUseCase.executedIds.count, 1)
    }


    private func makeSampleFavoriteCityWeather() -> FavoriteCityWeather {
        let city = FavoriteCity(
            id: UUID(uuidString: "A2F9B3E1-4F62-4EED-9C5B-D329D1893F21")!,
            name: "Istanbul",
            latitude: 41.01,
            longitude: 28.97
        )

        let current = CurrentWeather(
            date: Date(),
            temperature: 12.3,
            feelsLike: 11.1,
            humidity: 60,
            windSpeed: 3.2,
            pressure: 1015,
            sunrise: Date(),
            sunset: Date(),
            condition: "Clouds",
            icon: "02d"
        )

        let weather = Weather(
            timezone: "Europe/Istanbul",
            current: current,
            hourly: [],
            daily: []
        )

        return FavoriteCityWeather(city: city, weather: weather)
    }

}

private extension FavoriteState {
    var loadedList: [FavoriteCityUIModel]? {
        if case .loaded(let list) = self { return list }
        return nil
    }
}
