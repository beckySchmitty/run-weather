//
//  FilteredWeatherView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/26/23.
//

import SwiftUI

struct FilteredWeatherView: View {
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
	@ObservedObject var user: User
	@Binding var isFilteredByUserPref: Bool

	var filteredWeather: [HourlyWeather] {
		//		swiftlint:disable line_length
		if isFilteredByUserPref {
			// Parse the temperature preference
			guard let selectedTemp = Double(user.preferences.selectedTemperature.trimmingCharacters(in: CharacterSet(charactersIn: "°F"))) else {
				print("Error parsing selected temperature preference. Using default value.")
				return hourlyWeatherStore.hourlyWeather
			}
			// Parse the precipitation preference
			guard let selectedPrecip = Int(user.preferences.selectedPrecipitation.trimmingCharacters(in: CharacterSet(charactersIn: "< %"))) else {
				print("Error parsing selected precipitation preference. Using default value.")
				return hourlyWeatherStore.hourlyWeather
			}
			//		swiftlint:enable line_length


			// Filter weather data based on these preferences
			let filteredData = hourlyWeatherStore.hourlyWeather.filter { weather in
				weather.temperature >= selectedTemp && weather.precipitationProbability <= selectedPrecip
			}
			print("Successfully filtered \(filteredData.count) weather records based on user preferences.")
			return filteredData
		} else {
			return hourlyWeatherStore.hourlyWeather
		}
	}

	var body: some View {
		WeatherListView(filteredWeather: filteredWeather, user: user)
	}
}
