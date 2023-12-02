////
////  HourDetailViewUITest.swift
////  runWeatherUITests
////
////  Created by Becky Schmitthenner on 11/26/23.
////
//
import XCTest

final class HourDetailViewUITest: XCTestCase {
	//    swiftlint:disable:next implicitly_unwrapped_optional
	var app: XCUIApplication!

	func attemptToggleTap(_ testDataToggle: XCUIElement) {
		let maxAttempts = 2
		var currentAttempt = 0

		func tapElement() -> Bool {
			if testDataToggle.switches.firstMatch.waitForExistence(timeout: 2) {
				testDataToggle.switches.firstMatch.tap()
				return true
			} else if testDataToggle.waitForExistence(timeout: 2) && testDataToggle.isHittable {
				testDataToggle.tap()
				return true
			}
			return false
		}

		while currentAttempt < maxAttempts {
			if tapElement() {
				return // Success, exit the function
			}
			currentAttempt += 1
		}
		XCTFail("Failed to tap the toggle after \(maxAttempts) attempts.")
	}

	override func setUpWithError() throws {
		//            toggle on test data, then navigate to hour detail view
		app = .init()
		app.launch()
		app.tabBars["Tab Bar"].buttons["Profile"].tap()

		let testDataToggle = app.switches["testDataToggle"]
		let exists = NSPredicate(format: "exists == 1")
		expectation(for: exists, evaluatedWith: testDataToggle, handler: nil)
		waitForExpectations(timeout: 10)
		attemptToggleTap(testDataToggle)
		app.tabBars["Tab Bar"].buttons["Hourly"].tap()
		let firstRow = app.cells.element(boundBy: 0)
		XCTAssertTrue(firstRow.waitForExistence(timeout: 4), "The first row does not exist.")
		firstRow.tap()

		continueAfterFailure = false
	}

	func testWeatherIconPhrasePresence() {
		let weatherIconPhrase = app.staticTexts["weatherIconPhrase"]
		XCTAssertTrue(weatherIconPhrase.waitForExistence(timeout: 4), "Weather icon phrase is not present.")
	}

	func testTemperatureDisplayPresence() {
		let temperatureDisplay = app.staticTexts["hourDetailCardTemperature"]
		XCTAssertTrue(temperatureDisplay.waitForExistence(timeout: 4), "Temperature display is not present.")
	}
}
