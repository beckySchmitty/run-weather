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
	var userStore: UserStore!

	override func setUpWithError() throws {
		super.setUp()
		let userModel = UserModel()
		userStore = UserStore(user: userModel)
	}

	override func tearDownWithError() throws {
		userStore = nil
		super.tearDown()
	}

	func testInitializationWithDefaultValues() {
		XCTAssertEqual(userStore.zipCode, "")
		XCTAssertEqual(userStore.locationKey, "")
		XCTAssertEqual(userStore.localizedName, "")
		XCTAssertFalse(userStore.isTestDataEnabled)
	}

	func testInitializationWithCustomValues() {
		let customUserModel = UserModel(
			zipCode: "12345",
			locationKey: "CustomKey",
			localizedName: "CustomName",
			isTestDataEnabled: true,
			preferences: Preferences(selectedTemperature: "75", selectedPrecipitation: "10")
		)
		userStore = UserStore(user: customUserModel)
		XCTAssertEqual(userStore.zipCode, "12345")
		XCTAssertEqual(userStore.locationKey, "CustomKey")
		XCTAssertEqual(userStore.localizedName, "CustomName")
		XCTAssertTrue(userStore.isTestDataEnabled)
		XCTAssertEqual(userStore.user.preferences.selectedTemperature, "75")
		XCTAssertEqual(userStore.user.preferences.selectedPrecipitation, "10")
	}

	func testPreferenceChange() {
		userStore.user.preferences.selectedTemperature = "90°F"
		XCTAssertEqual(userStore.user.preferences.selectedTemperature, "90°F")
	}

	func testLocalizedNameChange() {
		let initialName = userStore.localizedName
		let newName = "New Localized Name"
		userStore.localizedName = newName
		XCTAssertNotEqual(userStore.localizedName, initialName)
		XCTAssertEqual(userStore.localizedName, newName)
	}

	func testTestDataEnabling() {
		XCTAssertFalse(userStore.isTestDataEnabled)
		userStore.isTestDataEnabled = true
		XCTAssertTrue(userStore.isTestDataEnabled)
		userStore.isTestDataEnabled = false
		XCTAssertFalse(userStore.isTestDataEnabled)
	}
}
