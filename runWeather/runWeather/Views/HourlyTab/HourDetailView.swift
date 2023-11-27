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
		ScrollView {
			VStack {
				Spacer()

				VStack(alignment: .leading, spacing: 20) {
					Text(weather.iconPhrase.uppercased())
						.font(.title)
						.fontWeight(.bold)
						.foregroundColor(.white)
						.accessibilityIdentifier("weatherIconPhrase")

					Image(systemName: WeatherIcon.iconForWeather(weather.weatherIcon).systemName)
						.font(.system(size: 100))
						.foregroundColor(Color("weatherIcon"))
						.accessibilityIdentifier("weatherImage")

					Text("\(Int(weather.temperature.rounded()))°")
						.font(.system(size: 80, weight: .thin))
						.foregroundColor(.white)
						.accessibilityIdentifier("temperatureDisplay")

					HourDetailCardView(title: "Hour", value: "\(convertToHourWithTimeZone(weather.dateTime) ?? "N/A")")
						.accessibilityIdentifier("hourDetailCardHour")
					// swiftlint:disable:next line_length
					HourDetailCardView(title: "Date", value: "\(convertToMonthDayYear(weather.dateTime) ?? "N/A"), \(convertToHourWithTimeZone(weather.dateTime) ?? "N/A")")
						.accessibilityIdentifier("hourDetailCardDate")

					HourDetailCardView(title: "Temperature", value: "\(Int(weather.temperature.rounded())) \(weather.temperatureUnit)")
						.accessibilityIdentifier("hourDetailCardTemperature")

					HourDetailCardView(title: "Precipitation Probability", value: "\(weather.precipitationProbability)%")
						.accessibilityIdentifier("hourDetailCardPrecipitationProbability")

					HourDetailLinkView(title: "Full Details", linkDestination: "\(weather.mobileLink)")
						.accessibilityIdentifier("hourDetailLinkFullDetails")
					Spacer()
				}
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color.purple)
				.cornerRadius(20)
				.padding(.horizontal)
				Spacer()
			}
		}
		.navigationTitle("Hourly Detail")
		.navigationBarTitleDisplayMode(.inline)
	}
}
