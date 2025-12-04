//
//  ImageLoaderActorTests.swift
//  NimbusWeatherTests
//
//  Created by Gorgun, Baris on 4.12.2025.
//

import XCTest
@testable import NimbusWeather

final class ImageLoaderActorTests: XCTestCase {

    func test_loadImage_returnsCachedImage_onSecondCall() async throws {
        // Given
        let mockSession = MockImageLoaderSession()
        mockSession.dataToReturn = UIImage(systemName: "sun.max")!.pngData()

        let loader = ImageLoaderActor(session: mockSession)
        let url = URL(string: "https://example.com/sun.png")!

        // When
        _ = try await loader.loadImage(from: url)
        _ = try await loader.loadImage(from: url)

        // Then
        XCTAssertEqual(mockSession.loadCallCount, 1)
    }

    func test_loadImage_throwsError_whenInvalidImageData() async throws {
        // Given
        let mockSession = MockImageLoaderSession()
        mockSession.dataToReturn = Data([0x00, 0x11, 0x22])

        let loader = ImageLoaderActor(session: mockSession)
        let url = URL(string: "https://example.com/bad.png")!

        // When / Then
        do {
            _ = try await loader.loadImage(from: url)
            XCTFail("Expected invalid image data to throw error")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    func test_loadImage_loadsOnce_withConcurrentCalls() async throws {
        let mockSession = MockImageLoaderSession()
        mockSession.dataToReturn = UIImage(systemName: "cloud")!.pngData()

        let loader = ImageLoaderActor(session: mockSession)
        let url = URL(string: "https://example.com/cloud.png")!

        async let img1 = loader.loadImage(from: url)
        async let img2 = loader.loadImage(from: url)
        _ = try await [img1, img2]

        XCTAssertEqual(mockSession.loadCallCount, 1)
    }
}
