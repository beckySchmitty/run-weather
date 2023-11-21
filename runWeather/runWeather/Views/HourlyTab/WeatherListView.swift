//
//  WeatherListView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/17/23.
//

import SwiftUI


struct WeatherListView: View {
	let filteredWeather: [HourlyWeather]
	@ObservedObject var user: User


	var body: some View {
		VStack {
			if filteredWeather.isEmpty {
				Text("No sun")
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			} else {
				List(filteredWeather, id: \.epochDateTime) { weather in
					HourlyWeatherRow(weather: weather)
				}
			}
		}
		.background(user.isDarkModeEnabled ? Color("backgroundBlue") : Color.white)
	}
}
