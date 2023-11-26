//
//  WeatherIconTests.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import XCTest
@testable import runWeather

class WeatherIconTests: XCTestCase {
	func testIconRawValues() {
		XCTAssertEqual(WeatherIcon.sunny.rawValue, 1)
		XCTAssertEqual(WeatherIcon.mostlySunny.rawValue, 2)
	}

	func testIconForWeather() {
		XCTAssertEqual(WeatherIcon.iconForWeather(1), .sunny)
		XCTAssertEqual(WeatherIcon.iconForWeather(2), .mostlySunny)
		XCTAssertEqual(WeatherIcon.iconForWeather(999), .cloudy, "Should return .cloudy for unknown raw values")
	}

	func testSystemNameForIcons() {
		XCTAssertEqual(WeatherIcon.sunny.systemName, "sun.max.fill")
		XCTAssertEqual(WeatherIcon.mostlySunny.systemName, "cloud.sun.fill")
	}

	func testColorForIcons() {
		XCTAssertEqual(WeatherIcon.sunny.color(), .yellow)
		XCTAssertEqual(WeatherIcon.fog.color(), .gray.opacity(0.5))
	}
}
