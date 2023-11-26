//
//  HourlyWeatherModelTests.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/25/23.
//
import XCTest
@testable import runWeather

@MainActor
class HourlyWeatherTests: XCTestCase {
	//	swiftlint:disable:next implicitly_unwrapped_optional
	var mockHourlyWeather: HourlyWeather!

	override func setUp() {
		super.setUp()
		mockHourlyWeather = MockHourlyWeatherModel.createMockHourlyWeatherModel()
	}

	override func tearDown() {
		mockHourlyWeather = nil
		super.tearDown()
	}

	func testMockHourlyWeatherModel() {
		XCTAssertEqual(mockHourlyWeather.dateTime, "2023-11-14T15:00:00-05:00")
		XCTAssertEqual(mockHourlyWeather.epochDateTime, 1636914000)
		XCTAssertEqual(mockHourlyWeather.weatherIcon, 6)
		// ... Continue with other assertions
	}

	// Test for verifying temperature value
	func testTemperatureValue() {
		let expectedTemperature = 57.0 // Replace with the expected value
		XCTAssertEqual(mockHourlyWeather.temperature, expectedTemperature, "Temperature value does not match expected value.")
	}

	// Test for verifying the formatAsInteger function
	func testFormatAsInteger() {
		let testValue: Double = 123.456
		let formattedValue = String.formatAsInteger(testValue)
		XCTAssertEqual(formattedValue, "123", "The formatAsInteger function did not format correctly.")
	}

	// Test to ensure proper formatting of the date string
	func testDateFormatting() {
		let dateFormatter = ISO8601DateFormatter()
		let date = dateFormatter.date(from: mockHourlyWeather.dateTime)
		XCTAssertNotNil(date, "Date string should be properly formatted in ISO8601 format.")
	}
}
