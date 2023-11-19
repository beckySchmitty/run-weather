//
//  WeatherListView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/17/23.
//

import SwiftUI


struct WeatherListView: View {
	let filteredWeather: [HourlyWeather]

	var body: some View {
		if filteredWeather.isEmpty {
			Text("No sun")
				.frame(maxWidth: .infinity, maxHeight: .infinity)
		} else {
			List(filteredWeather, id: \.epochDateTime) { weather in
				HourlyWeatherRow(weather: weather)
			}
		}
	}
}
