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
	//	swiftlint:disable implicitly_unwrapped_optional
	//	swiftlint:disable line_length
	var mockHourlyWeather: [HourlyWeather]!

	override func setUp() {
		super.setUp()
		mockHourlyWeather = MockHourlyWeatherModel.createMockHourlyWeatherModel()
	}

	override func tearDown() {
		mockHourlyWeather = nil
		super.tearDown()
	}

	func testMockHourlyWeatherModel() {
		let testHourlyWeather = mockHourlyWeather[0]
		XCTAssertEqual(testHourlyWeather.dateTime, "2023-11-27T00:00:00-05:00")
		XCTAssertEqual(testHourlyWeather.epochDateTime, 1701061200)
		XCTAssertEqual(testHourlyWeather.weatherIcon, 12)
	}

	func testTemperatureValue() {
		let expectedTemperature = 38.0
		XCTAssertEqual(mockHourlyWeather[0].temperature, expectedTemperature, "Temperature value does not match expected value.")
	}

	func testFormatAsInteger() {
		let testValue: Double = 123.456
		let formattedValue = String.formatAsInteger(testValue)
		XCTAssertEqual(formattedValue, "123", "The formatAsInteger function did not format correctly.")
	}

	func testDateFormatting() {
		let dateFormatter = ISO8601DateFormatter()
		let date = dateFormatter.date(from: mockHourlyWeather[0].dateTime)
		XCTAssertNotNil(date, "Date string should be properly formatted in ISO8601 format.")
	}

	func testPrecipitationProbability() {
		let expectedPrecipitationProbability = 90
		XCTAssertEqual(mockHourlyWeather[0].precipitationProbability, expectedPrecipitationProbability, "Precipitation probability does not match expected value.")
	}
}

//	swiftlint:enable implicitly_unwrapped_optional
//	swiftlint:enable line_length
