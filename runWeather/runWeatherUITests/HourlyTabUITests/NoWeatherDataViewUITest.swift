//
//  NoWeatherDataViewTest.swift
//  runWeatherUITests
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import XCTest

final class NoWeatherDataViewUITest: XCTestCase {
	//	swiftlint:disable:next implicitly_unwrapped_optional
	var app: XCUIApplication!

	override func setUpWithError() throws {
		app = .init()
		app.launch()

		continueAfterFailure = false
	}

	func testNoWeatherDataViewIsPresented() throws {
		let noWeatherText = app.staticTexts["Update your profile to see the weather forecast"]
		XCTAssertTrue(noWeatherText.exists, "NoWeatherDataView is not presented when it should be.")
	}

	func testCloudImageExists() throws {
		let cloudImage = app.images["cloudSunImage"]
		XCTAssertTrue(cloudImage.exists, "Cloud image does not exist in the NoWeatherDataView.")
	}

	func testCircularAnimation() throws {
		let cloudImage = app.images["cloudSunImage"]
		let initialFrame = cloudImage.frame
		sleep(2)

		// Get the new position of the image
		let newFrame = cloudImage.frame

		// Verify the image has moved
		XCTAssertNotEqual(initialFrame, newFrame, "The cloud image has not moved, animation might not be active.")
	}


	func testLaunchPerformance() throws {
		if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
			// This measures how long it takes to launch your application.
			measure(metrics: [XCTApplicationLaunchMetric()]) {
				XCUIApplication().launch()
			}
		}
	}
}
