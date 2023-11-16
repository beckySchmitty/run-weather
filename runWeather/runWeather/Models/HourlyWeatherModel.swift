//
//  HourlyWeatherModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import Foundation

struct HourlyWeatherData: Decodable {
	let dateTime: String
	let epochDateTime: Int
	let weatherIcon: Int
	let iconPhrase: String
	let hasPrecipitation: Bool
	let isDaylight: Bool
	let temperature: Temperature
	let precipitationProbability: Int
	let mobileLink: String
	let link: String
	
	enum CodingKeys: String, CodingKey {
		case dateTime = "DateTime"
		case epochDateTime = "EpochDateTime"
		case weatherIcon = "WeatherIcon"
		case iconPhrase = "IconPhrase"
		case hasPrecipitation = "HasPrecipitation"
		case isDaylight = "IsDaylight"
		case temperature = "Temperature"
		case precipitationProbability = "PrecipitationProbability"
		case mobileLink = "MobileLink"
		case link = "Link"
	}
	
	var formattedDateTime: String {
		return convertToHourWithTimeZone(self.dateTime) ?? "Invalid Time"
	}
}

struct Temperature: Decodable {
	let value: Double
	let unit: String
	let unitType: Int
	
	enum CodingKeys: String, CodingKey {
		case value = "Value"
		case unit = "Unit"
		case unitType = "UnitType"
	}
}

class HourlyWeather {
	let dateTime: String
	let epochDateTime: Int
	let weatherIcon: Int
	let iconPhrase: String
	let hasPrecipitation: Bool
	let isDaylight: Bool
	let temperature: Double
	let temperatureUnit: String
	let precipitationProbability: Int
	let mobileLink: String
	let link: String
	
	init(from data: HourlyWeatherData) {
		self.dateTime = data.dateTime
		self.epochDateTime = data.epochDateTime
		self.weatherIcon = data.weatherIcon
		self.iconPhrase = data.iconPhrase
		self.hasPrecipitation = data.hasPrecipitation
		self.isDaylight = data.isDaylight
		self.temperature = data.temperature.value
		self.temperatureUnit = data.temperature.unit
		self.precipitationProbability = data.precipitationProbability
		self.mobileLink = data.mobileLink
		self.link = data.link
	}
	
	var formattedDateTime: String {
		return convertToHourWithTimeZone(self.dateTime) ?? "Invalid Time"
	}
}

extension String {
	static func formatAsInteger(_ value: Double) -> String {
		return String(format: "%.0f", value)
	}
}
