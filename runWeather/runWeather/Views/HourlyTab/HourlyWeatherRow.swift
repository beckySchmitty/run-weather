//
//  HourlyWeatherRow.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/15/23.
//

import SwiftUI

struct HourlyWeatherRow: View {
	let weather: HourlyWeather

	var body: some View {
		NavigationLink(destination: HourDetailView(weather: weather)) {
			HStack {
				Image(systemName: WeatherIcon.iconForWeather(weather.weatherIcon).systemName)
					.foregroundColor(weather.iconPhrase.lowercased().contains("sunny") ? .yellow : .gray)
				Text("\(String.formatAsInteger(weather.temperature)) \(weather.temperatureUnit)")
				VStack(alignment: .leading) {
					Text(weather.iconPhrase)
					Text(weather.formattedDateTime)
				}
			}
		}
	}
}
