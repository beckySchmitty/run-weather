//
//  MockHourlyWeather.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/25/23.
//

@testable import runWeather
import Foundation

@MainActor
class MockHourlyWeatherModel {

		static let defaultJSON = """
		{
				"DateTime": "2023-11-14T15:00:00-05:00",
				"EpochDateTime": 1636914000,
				"WeatherIcon": 6,
				"IconPhrase": "Mostly cloudy",
				"HasPrecipitation": false,
				"IsDaylight": true,
				"Temperature": {
						"Value": 57.0,
						"Unit": "F",
						"UnitType": 18
				},
				"PrecipitationProbability": 25,
				"MobileLink": "http://m.accuweather.com/en/us/new-york-ny/10007/hourly-weather-forecast/349727",
				"Link": "http://www.accuweather.com/en/us/new-york-ny/10007/hourly-weather-forecast/349727"
		}
		"""

		static func createMockHourlyWeatherModel() -> HourlyWeather {
				let jsonData = MockHourlyWeatherModel.defaultJSON.data(using: .utf8)!
				let hourlyWeatherData = try! JSONDecoder().decode(HourlyWeatherData.self, from: jsonData)
				return HourlyWeather(from: hourlyWeatherData)
		}
}
