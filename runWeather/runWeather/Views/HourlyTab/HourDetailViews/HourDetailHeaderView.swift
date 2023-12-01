//
//  MainWeatherDetails.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/30/23.
//

import SwiftUI


struct HourDetailHeaderView: View {
	let weather: HourlyWeather

	var body: some View {
		VStack {
			Text(weather.iconPhrase.uppercased())
				.font(.title)
				.fontWeight(.bold)
				.foregroundColor(.white)
				.accessibilityIdentifier("weatherIconPhrase")

			Image(systemName: WeatherIcon.iconForWeather(weather.weatherIcon).systemName)
				.font(.system(size: 100))
				.foregroundColor(Color("weatherIcon"))
				.accessibilityIdentifier("weatherImage")

			Text("\(Int(weather.temperature.rounded()))°F")
				.font(.system(size: 80, weight: .thin))
				.foregroundColor(.white)
				.accessibilityIdentifier("temperatureDisplay")
		}
	}
}
