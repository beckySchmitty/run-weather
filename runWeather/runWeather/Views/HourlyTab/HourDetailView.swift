//
//  HourDetailView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct HourDetailView: View {
	let weather: HourlyWeather
	
	var body: some View {
		VStack {
			Text("Date Time: \(weather.dateTime)")
			Text("Epoch Date Time: \(weather.epochDateTime)")
			Text("Weather Icon: \(weather.weatherIcon)")
			Text("Icon Phrase: \(weather.iconPhrase)")
			Text("Has Precipitation: \(weather.hasPrecipitation ? "Yes" : "No")")
			Text("Is Daylight: \(weather.isDaylight ? "Yes" : "No")")
			Text("Temperature: \(weather.temperature) \(weather.temperatureUnit)")
			Text("Precipitation Probability: \(weather.precipitationProbability)%")
			//            Text("Mobile Link: \(weather.mobileLink)")
			//            Text("Link: \(weather.link)")
		}
		.navigationTitle("Hourly Detail")
		.padding()
	}
}
