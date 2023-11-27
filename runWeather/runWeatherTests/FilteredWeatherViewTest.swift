//
//  FilteredWeatherViewTest.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/27/23.
//

import XCTest
@testable import runWeather

@MainActor
class FilteredWeatherViewTests: XCTestCase {
	//	swiftlint:disable implicitly_unwrapped_optional
	//	swiftlint:disable line_length
	//	swiftlint:disable indentation_width
	var hourlyWeatherStore: HourlyWeatherStore!
	var userStore: UserStore!
	//	swiftlint:enable implicitly_unwrapped_optional

	override func setUp() {
		super.setUp()
		hourlyWeatherStore = HourlyWeatherStore()
		userStore = UserStore()
		hourlyWeatherStore.hourlyWeather = MockHourlyWeatherModel.createMockHourlyWeatherModel()
	}

	override func tearDown() {
		hourlyWeatherStore = nil
		userStore = nil
		super.tearDown()
	}

	func testFilteredWeather_whenFilterIsOn() {
		// Arrange
		let isFilteredByUserPref = true

		// Act
		let filteredWeather = FilteredWeatherView.getFilteredWeather(
			from: hourlyWeatherStore.hourlyWeather,
			userPreferences: userStore.user.preferences,
			isFiltered: isFilteredByUserPref
		)

		// Assert
		let expectedFilteredWeather = hourlyWeatherStore.hourlyWeather.filter { weather in
			guard let selectedTemp = Double(userStore.user.preferences.selectedTemperature.trimmingCharacters(in: CharacterSet(charactersIn: "°F"))),
						let selectedPrecip = Int(userStore.user.preferences.selectedPrecipitation.trimmingCharacters(in: CharacterSet(charactersIn: "< %"))) else {
				return false
			}
			return weather.temperature >= selectedTemp && weather.precipitationProbability <= selectedPrecip
		}
		XCTAssertEqual(filteredWeather.count, expectedFilteredWeather.count, "Filtered weather should match the expected filtered results.")
	}
}

extension FilteredWeatherView {
	static func getFilteredWeather(from hourlyWeather: [HourlyWeather], userPreferences: Preferences, isFiltered: Bool) -> [HourlyWeather] {
		if isFiltered {
			// Parse the user's temperature preference
			guard let selectedTemp = Double(userPreferences.selectedTemperature.trimmingCharacters(in: CharacterSet(charactersIn: "°F"))),
						// Parse the user's precipitation preference
						let selectedPrecip = Int(userPreferences.selectedPrecipitation.trimmingCharacters(in: CharacterSet(charactersIn: "< %"))) else {
				return hourlyWeather
			}

			// Filter the weather data based on the user's preferences
			return hourlyWeather.filter { weather in
				weather.temperature >= selectedTemp && weather.precipitationProbability <= selectedPrecip
			}
		} else {
			return hourlyWeather
		}
	}
}
//	swiftlint:enable line_length
//	swiftlint:enable indentation_width
