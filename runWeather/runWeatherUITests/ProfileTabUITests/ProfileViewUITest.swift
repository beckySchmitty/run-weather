//
//  ProfileViewUITest.swift
//  runWeatherUITests
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import XCTest

final class ProfileViewUITest: XCTestCase {
	//	swiftlint:disable:next implicitly_unwrapped_optional
	var app: XCUIApplication!

	override func setUpWithError() throws {
		app = .init()
		app.launch()
		app.tabBars["Tab Bar"].buttons["Profile"].tap()

		continueAfterFailure = false
	}

	func testProfileHeaderExists() throws {
		XCTAssertTrue(app.staticTexts["New User"].exists, "Profile header user name does not exist.")
	}

	func testZipCodeFieldIsEditable() throws {
		let zipCodeTextField = app.textFields["Zip Code"]
		XCTAssertTrue(zipCodeTextField.exists, "Zip code text field does not exist.")
		zipCodeTextField.tap()
		sleep(3)
		zipCodeTextField.typeText("12345")
		sleep(3)
		XCTAssertEqual(zipCodeTextField.value as? String, "12345", "Zip code text field is not editable.")
	}

	func testToggleTestData() throws {
		let testDataToggle = app.switches["testDataToggle"]
		XCTAssertTrue(testDataToggle.waitForExistence(timeout: 10), "Test data toggle does not exist.")
	}

	func testSavePreferencesButtonExistsAndClickable() throws {
		let savePreferencesButton = app.buttons["Save"]
		XCTAssertTrue(savePreferencesButton.exists, "Save Preferences button does not exist.")
		savePreferencesButton.tap()
	}

	func testPreferencesListed() throws {
		XCTAssertTrue(app.staticTexts["Temperature"].exists, "Temperature preference does not exist")
		XCTAssertTrue(app.staticTexts["Precipitation"].exists, "Precipitation level preference does not exist")
	}
}
