//
//  DateTimeHelpersTests.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import XCTest
@testable import runWeather

class DateTimeHelpersTests: XCTestCase {
	func testConvertToMonthDayYear() {
		let dateString = "2024-03-10T07:00:00Z"
		let formattedDate = convertToMonthDayYear(dateString)

		XCTAssertEqual(formattedDate, "March 10, 2024", "The date should be formatted to 'Month day, year'")
	}

	func testConvertToHourWithTimeZone() {
		let dateString = "2024-03-10T07:00:00Z"
		let formattedTime = convertToHourWithTimeZone(dateString)

		XCTAssertEqual(formattedTime, "3 AM EST", "The time should be formatted to 'hour am/pm EST'")
	}

	// Test cases to handle invalid date formats
	func testInvalidDateFormatReturnsNil() {
		let invalidDateString = "2024/03/10 07:00:00"

		XCTAssertNil(convertToMonthDayYear(invalidDateString), "The function should return nil for an invalid date string")
		//		swiftlint:disable:next line_length
		XCTAssertNil(convertToHourWithTimeZone(invalidDateString), "The function should return nil for an invalid date string")
	}
}
