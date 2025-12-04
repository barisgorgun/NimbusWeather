//
//  SettingsViewModelTests.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import XCTest
import CoreLocation
@testable import NimbusWeather

@MainActor
final class SettingsViewModelTests: XCTestCase {

    private var mockManager: MockLocationPermissionManager!
    private var viewModel: SettingsViewModel!

    override func setUp() {
        super.setUp()
        mockManager = MockLocationPermissionManager()
        viewModel = SettingsViewModel(locationPermissionManager: mockManager)
    }

    override func tearDown() {
        mockManager = nil
        viewModel = nil
        super.tearDown()
    }

    func test_refreshLocationStatus_updatesStatus() {
        // Given
        mockManager.mockStatus = .denied

        // When
        viewModel.refreshLocationStatus()

        // Then
        XCTAssertEqual(viewModel.locationStatus, .denied)
    }

    func test_requestLocationPermission_updatesStatus() async {
        // Given
        mockManager.mockStatus = .authorizedAlways

        // When
        await viewModel.requestLocationPermission()

        // Then
        XCTAssertTrue(mockManager.requestCalled)
        XCTAssertEqual(viewModel.locationStatus, .authorizedAlways)
    }
}
