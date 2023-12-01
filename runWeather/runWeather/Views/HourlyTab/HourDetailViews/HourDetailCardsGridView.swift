//
//  HourDetailCardsGridView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/30/23.
//

import SwiftUI


struct HourDetailCardsGridView: View {
	let weather: HourlyWeather
	var body: some View {
		Group {
			HourDetailCardView(title: "Hour", value: "\(convertToHourWithTimeZone(weather.dateTime) ?? "N/A")")
				.accessibilityIdentifier("hourDetailCardHour")
			HourDetailCardView(title: "Date", value: "\(convertToMonthDayYear(weather.dateTime) ?? "N/A")")
				.accessibilityIdentifier("hourDetailCardDate")
			HourDetailCardView(title: "Temperature", value: "\(Int(weather.temperature.rounded())) \(weather.temperatureUnit)")
				.accessibilityIdentifier("hourDetailCardTemperature")
			HourDetailCardView(title: "Precipitation Probability", value: "\(weather.precipitationProbability)%")
				.accessibilityIdentifier("hourDetailCardPrecipitationProbability")
			HourDetailLinkView(title: "Full Details", linkDestination: "\(weather.mobileLink)")
				.accessibilityIdentifier("hourDetailLinkFullDetails")
		}
	}
}
