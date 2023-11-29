//
//  WeatherListView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/17/23.
//

import SwiftUI

struct WeatherListView: View {
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
	@ObservedObject var userStore: UserStore
	@Binding var isFilteredByUserPref: Bool

	// swiftlint:disble line_length
	var body: some View {
		VStack {
			if filteredWeather.isEmpty {
				Text("No weather matches your current preferences. Please update your preferences or wait for the weather to change.")
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else {
				List(filteredWeather, id: \.epochDateTime) { weather in
					HourlyWeatherRow(weather: weather)
						.accessibilityIdentifier("HourlyWeatherRow-\(weather.dateTime)")
				}
			}
		}
		.background(Color("backgroundBlue"))
	}

	var filteredWeather: [HourlyWeather] {
		if isFilteredByUserPref {
			return filterWeatherBasedOnPreferences()
		} else {
			return hourlyWeatherStore.hourlyWeather
		}
	}

	func filterWeatherBasedOnPreferences() -> [HourlyWeather] {
		guard let selectedTemp = Double(userStore.user.preferences.selectedTemperature.trimmingCharacters(in: CharacterSet(charactersIn: "°F"))) else {
			print("Error parsing selected temperature preference. Using default value.")
			return hourlyWeatherStore.hourlyWeather
		}
		guard let selectedPrecip = Int(userStore.user.preferences.selectedPrecipitation.trimmingCharacters(in: CharacterSet(charactersIn: "< %"))) else {
			print("Error parsing selected precipitation preference. Using default value.")
			return hourlyWeatherStore.hourlyWeather
		}
		return hourlyWeatherStore.hourlyWeather.filter { weather in
			weather.temperature >= selectedTemp && weather.precipitationProbability <= selectedPrecip
		}
	}
}
// swiftlint:enable line_length
