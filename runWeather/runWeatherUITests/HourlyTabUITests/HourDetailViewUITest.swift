//
//  HourDetailViewUITest.swift
//  runWeatherUITests
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import XCTest

final class HourDetailViewUITest: XCTestCase {
	//	swiftlint:disable:next implicitly_unwrapped_optional
	var app: XCUIApplication!

	override func setUpWithError() throws {
		//			toggle on test data, then navigate to hour detail view
		app = .init()
		app.launch()
		app.tabBars["Tab Bar"].buttons["Profile"].tap()

		let testDataToggle = app.switches["testDataToggle"]
		let exists = NSPredicate(format: "exists == 1")
		expectation(for: exists, evaluatedWith: testDataToggle, handler: nil)
		waitForExpectations(timeout: 5)
		testDataToggle.switches.firstMatch.tap()

		app.tabBars["Tab Bar"].buttons["Hourly"].tap()
		let firstRow = app.cells.element(boundBy: 0)
		XCTAssertTrue(firstRow.exists, "The first row does not exist.")
		firstRow.tap()

		continueAfterFailure = false
	}

	override func tearDownWithError() throws {
		// Put teardown code here.
	}

	func testWeatherIconPhrasePresence() {
		let weatherIconPhrase = app.staticTexts["weatherIconPhrase"]
		XCTAssertTrue(weatherIconPhrase.exists, "Weather icon phrase is not present.")
	}

	func testTemperatureDisplayPresence() {
		let temperatureDisplay = app.staticTexts["hourDetailCardTemperature"]
		XCTAssertTrue(temperatureDisplay.exists, "Temperature display is not present.")
	}
}
