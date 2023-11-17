//
//  WeatherIconEnum.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/16/23.
//

import Foundation
import SwiftUI

enum WeatherIcon: Int {
	case sunny = 1
	case mostlySunny = 2
	case partlySunny = 3
	case intermittentClouds = 4
	case hazySunshine = 5
	case mostlyCloudy = 6
	case cloudy = 7
	case dreary = 8
	case fog = 11
	case showers = 12
	case mostlyCloudyShowers = 13
	case partlySunnyShowers = 14
	case tStorms = 15
	case mostlyCloudyTStorms = 16
	case partlySunnyTStorms = 17
	case rain = 18
	case flurries = 19
	case mostlyCloudyFlurries = 20
	case partlySunnyFlurries = 21
	case snow = 22
	case mostlyCloudySnow = 23
	case ice = 24
	case sleet = 25
	case freezingRain = 26
	case rainAndSnow = 29
	case hot = 30
	case cold = 31
	case windy = 32
	case clear = 33
	case mostlyClear = 34
	case partlyCloudy = 35
	case intermittentCloudsNight = 36
	case hazyMoonlight = 37
	case mostlyCloudyNight = 38
	case partlyCloudyShowersNight = 39
	case mostlyCloudyShowersNight = 40
	case partlyCloudyTStormsNight = 41
	case mostlyCloudyTStormsNight = 42
	case mostlyCloudyFlurriesNight = 43
	case mostlyCloudySnowNight = 44

	static func iconForWeather(_ iconNumber: Int) -> WeatherIcon {
		return WeatherIcon(rawValue: iconNumber) ?? .cloudy
	}

	var systemName: String {
		switch self {
		case .sunny:
			return "sun.max.fill"
		case .mostlySunny:
			return "cloud.sun.fill"
		case .partlySunny:
			return "cloud.sun.fill"
		case .intermittentClouds, .intermittentCloudsNight:
			return "cloud.fill"
		case .hazySunshine, .hazyMoonlight:
			return "sun.haze.fill"
		case .mostlyCloudy, .mostlyCloudyNight:
			return "smoke.fill"
		case .cloudy:
			return "cloud.fill"
		case .dreary:
			return "cloud.fog.fill"
		case .fog:
			return "cloud.fog.fill"
		case .showers, .mostlyCloudyShowers, .mostlyCloudyShowersNight:
			return "cloud.drizzle.fill"
		case .partlySunnyShowers, .partlyCloudyShowersNight:
			return "cloud.sun.rain.fill"
		case .tStorms, .mostlyCloudyTStorms, .mostlyCloudyTStormsNight:
			return "cloud.bolt.rain.fill"
		case .partlySunnyTStorms, .partlyCloudyTStormsNight:
			return "cloud.sun.bolt.fill"
		case .rain:
			return "cloud.rain.fill"
		case .flurries, .mostlyCloudyFlurries, .mostlyCloudyFlurriesNight:
			return "cloud.snow.fill"
		case .mostlyCloudySnow, .mostlyCloudySnowNight:
			return "cloud.snow.fill"
		case .partlySunnyFlurries:
			return "cloud.sun.snow.fill"
		case .snow:
			return "snowflake"
		case .ice:
			return "thermometer.snowflake"
		case .sleet:
			return "cloud.sleet.fill"
		case .freezingRain:
			return "cloud.hail.fill"
		case .rainAndSnow:
			return "cloud.sleet.fill"
		case .hot:
			return "thermometer.sun.fill"
		case .cold:
			return "thermometer.snowflake"
		case .windy:
			return "wind"
		case .clear:
			return "moon.stars.fill"
		case .mostlyClear:
			return "cloud.moon.fill"
		case .partlyCloudy:
			return "cloud.moon.fill"
		}
	}
}
