//
//  HourlyWeatherViewTests.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/21/23.
//

import Foundation

import XCTest
@testable import runWeather

class HourlyWeatherViewTests: XCTestCase {
	var mockHourlyWeatherStore: MockHourlyWeatherStore!
	var mockUser: MockUser!
	var hourlyWeatherView: HourlyWeatherView!

	@MainActor
	override func setUp() {
			super.setUp()
			mockHourlyWeatherStore = MockHourlyWeatherStore()
			mockUser = MockUser()
			// No casting is needed here, just apply the environmentObject modifier
		hourlyWeatherView = HourlyWeatherView(user: mockUser).environmentObject(mockHourlyWeatherStore) as! HourlyWeatherView
	}

	func testWeatherFiltering() {
		// Test sunny weather filtering
		hourlyWeatherView.onlyShowSunny = true
		XCTAssertTrue(hourlyWeatherView.filteredWeather.allSatisfy { $0.iconPhrase.lowercased().contains("sunny") })

		// Test without filtering
		hourlyWeatherView.onlyShowSunny = false
		XCTAssertEqual(hourlyWeatherView.filteredWeather.count, mockHourlyWeatherStore.hourlyWeather.count)
	}


	func testErrorHandling() {
		// Simulate an error in the weather store
//		mockHourlyWeatherStore.simulateError("Test Error")

		// Assert that the alert is shown with the correct message
//		XCTAssertTrue(hourlyWeatherView.hourlyWeatherStore.hasError)
//		XCTAssertEqual(hourlyWeatherView.hourlyWeatherStore.errorMessage, "Test Error")
	}
}

class MockHourlyWeatherStore: ObservableObject, HourlyWeatherStoreProtocol {
		var hourlyWeather: [HourlyWeather] = []

		 init() {
				let weatherData = [
						HourlyWeatherData(dateTime: "2023-11-21T21:00:00-05:00", epochDateTime: 1700618400, weatherIcon: 38, iconPhrase: "Mostly cloudy", hasPrecipitation: false, isDaylight: false, temperature: Temperature(value: 48.0, unit: "F", unitType: 18), precipitationProbability: 32, mobileLink: "http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=1&hbhhour=21&lang=en-us", link: "http://www.accuweather.com/en/us/westerville-oh/43081/hourly-weather-forecast/18404_pc?day=1&hbhhour=21&lang=en-us"),
						// TODO: add more
				]
				self.hourlyWeather = weatherData.map(HourlyWeather.init)
		}
}
