//
//  WeatherListView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/17/23.
//

import SwiftUI


struct WeatherListView: View {
	let filteredWeather: [HourlyWeather]
	@ObservedObject var userStore: UserStore

	var body: some View {
		VStack {
			if filteredWeather.isEmpty {
				//				swiftlint:disable:next line_length
				Text("No weather matches your current preferences; please update your preferences or wait for the weather to change")
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else {
				List(filteredWeather, id: \.epochDateTime) { weather in
					HourlyWeatherRow(weather: weather)
						.accessibilityIdentifier("HourlyWeatherRow-\(weather.dateTime)")
				}
			}
		}
	}
}
