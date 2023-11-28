//
//  UserModelTests.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/25/23.
//

import XCTest
@testable import runWeather

@MainActor
class UserStoreTests: XCTestCase {
	// swiftlint:disable line_length
	// swiftlint:disable indentation_width

	//	swiftlint:disable:next implicitly_unwrapped_optional
	var userStore: UserStore!

	override func setUpWithError() throws {
		super.setUp()
	}

	override func tearDownWithError() throws {
		userStore = nil
		super.tearDown()
	}

	func testSavingNewPreferences() {
			// Arrange
			userStore = UserStore()
			let newPreferences = Preferences(selectedTemperature: "70°F", selectedPrecipitation: "< 50%")

			// Act
			userStore.user.preferences = newPreferences
			userStore.savePreferences()

			// Assert
			let savedPreferences = userStore.loadPreferences()
			XCTAssertEqual(savedPreferences.selectedTemperature, "70°F")
			XCTAssertEqual(savedPreferences.selectedPrecipitation, "< 50%")
	}

	func testLoadingPreferences() {
			// Arrange
			userStore = UserStore()

			let newPreferences = Preferences(selectedTemperature: "10°F", selectedPrecipitation: "< 90%")
			userStore.user.preferences = newPreferences
			userStore.savePreferences()

			// Act
			let loadedPreferences = userStore.loadPreferences()

			// Assert
			XCTAssertEqual(loadedPreferences.selectedTemperature, "10°F", "Loaded temperature preference should match the saved value.")
			XCTAssertEqual(loadedPreferences.selectedPrecipitation, "< 90%", "Loaded precipitation preference should match the saved value.")
	}
}
// swiftlint:enable line_length
// swiftlint:enable indentation_width
