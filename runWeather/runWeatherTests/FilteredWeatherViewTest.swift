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
	var user: User!
	//	swiftlint:enable implicitly_unwrapped_optional

	override func setUp() {
		super.setUp()
		hourlyWeatherStore = HourlyWeatherStore()
		user = User()
		hourlyWeatherStore.hourlyWeather = MockHourlyWeatherModel.createMockHourlyWeatherModel()
	}

	override func tearDown() {
		hourlyWeatherStore = nil
		user = nil
		super.tearDown()
	}

	func testFilteredWeather_whenFilterIsOn() {
		// Arrange
		let isFilteredByUserPref = true

		// Act
		let filteredWeather = FilteredWeatherView.getFilteredWeather(
			from: hourlyWeatherStore.hourlyWeather,
			user: user,
			isFiltered: isFilteredByUserPref
		)

		// Assert
		let expectedFilteredWeather = hourlyWeatherStore.hourlyWeather.filter { weather in
			guard let selectedTemp = Double(user.preferences.selectedTemperature.trimmingCharacters(in: CharacterSet(charactersIn: "°F"))),
						let selectedPrecip = Int(user.preferences.selectedPrecipitation.trimmingCharacters(in: CharacterSet(charactersIn: "< %"))) else {
				return false
			}
			return weather.temperature >= selectedTemp && weather.precipitationProbability <= selectedPrecip
		}
		XCTAssertEqual(filteredWeather.count, expectedFilteredWeather.count, "Filtered weather should match the expected filtered results.")
	}
}

extension FilteredWeatherView {
	static func getFilteredWeather(from hourlyWeather: [HourlyWeather], user: User, isFiltered: Bool) -> [HourlyWeather] {
		if isFiltered {
			guard let selectedTemp = Double(user.preferences.selectedTemperature.trimmingCharacters(in: CharacterSet(charactersIn: "°F"))),
						let selectedPrecip = Int(user.preferences.selectedPrecipitation.trimmingCharacters(in: CharacterSet(charactersIn: "< %"))) else {
				return hourlyWeather
			}

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
