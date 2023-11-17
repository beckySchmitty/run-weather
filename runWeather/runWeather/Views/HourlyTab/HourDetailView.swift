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

					Text("\(Int(weather.temperature.rounded()))°")
						.font(.system(size: 80, weight: .thin))
						.foregroundColor(.white)
					// swiftlint:disable:next line_length
					HourDetailCardView(title: "Date Time", value: "\(convertToMonthDayYear(weather.dateTime) ?? "N/A"), \(convertToHourWithTimeZone(weather.dateTime) ?? "N/A")")
					HourDetailCardView(title: "Temperature", value: "\(Int(weather.temperature.rounded())) \(weather.temperatureUnit)")
					HourDetailCardView(title: "Precipitation Probability", value: "\(weather.precipitationProbability)%")

					Spacer()
				}
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				.background(Color.blue)
				.cornerRadius(20)
				.padding(.horizontal)

				Spacer()
			}
		}
		.navigationTitle("Hourly Detail")
		.navigationBarTitleDisplayMode(.inline)
	}
}
