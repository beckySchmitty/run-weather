//
//  UserModelTests.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/25/23.
//

import XCTest
@testable import runWeather

@MainActor
class UserModelTests: XCTestCase {
	//	swiftlint:disable:next implicitly_unwrapped_optional
	var user: User!

	override func setUpWithError() throws {
		super.setUp()
		// Initialize the User object before each test
		user = User()
	}

	override func tearDownWithError() throws {
		// Clean up and nullify the User object after each test
		user = nil
		super.tearDown()
	}

	func testInitializationWithDefaultValues() {
		XCTAssertEqual(user.zipCode, "")
		XCTAssertEqual(user.locationKey, "")
		XCTAssertEqual(user.localizedName, "")
		XCTAssertFalse(user.isTestDataEnabled)
		// Add more asserts for default preferences if needed
	}

	func testInitializationWithCustomValues() {
		//		swiftlint:disable:next line_length
		let customUser = User(zipCode: "12345", locationKey: "CustomKey", localizedName: "CustomName", isTestDataEnabled: true)
		XCTAssertEqual(customUser.zipCode, "12345")
		XCTAssertEqual(customUser.locationKey, "CustomKey")
		XCTAssertEqual(customUser.localizedName, "CustomName")
		XCTAssertTrue(customUser.isTestDataEnabled)
		// Add more asserts for custom preferences if needed
	}

	func testPropertyObservability() {
		let expectation = XCTestExpectation(description: "Property change should be observed")

		var didChange = false
		let cancellable = user.$zipCode.sink { _ in
			didChange = true
			expectation.fulfill()
		}

		user.zipCode = "99999"
		wait(for: [expectation], timeout: 1.0)
		XCTAssertTrue(didChange)

		cancellable.cancel()
	}

	func testTestDataEnabling() {
		XCTAssertFalse(user.isTestDataEnabled)
		user.isTestDataEnabled = true
		XCTAssertTrue(user.isTestDataEnabled)
		user.isTestDataEnabled = false
		XCTAssertFalse(user.isTestDataEnabled)
	}

	func testUserPreferenceChange() {
		// Change the preference
		user.preferences.selectedTemperature = "90°F"
		XCTAssertEqual(user.preferences.selectedTemperature, "90°F")
	}

	func testLocalizedNameChange() {
		let initialName = user.localizedName
		let newName = "New Localized Name"
		user.localizedName = newName
		XCTAssertNotEqual(user.localizedName, initialName)
		XCTAssertEqual(user.localizedName, newName)
	}
}
