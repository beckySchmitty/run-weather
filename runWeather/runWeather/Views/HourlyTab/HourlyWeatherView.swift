//
//  HourlyWeatherView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct HourlyWeatherView: View {
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
	@EnvironmentObject var appSettings: AppSettings
	@ObservedObject var user: User
	@State private var onlyShowSunny = false

	var filteredWeather: [HourlyWeather] {
		onlyShowSunny ? hourlyWeatherStore.hourlyWeather.filter { $0.iconPhrase.lowercased().contains("sunny") }
		: hourlyWeatherStore.hourlyWeather
	}

	var body: some View {
		NavigationStack {
			if user.locationKey.isEmpty {
				NoWeatherDataView(hourlyWeatherStore: hourlyWeatherStore, user: user)
			} else {
				List {
					ForEach(hourlyWeatherStore.hourlyWeather.filter { weather in
						!onlyShowSunny || weather.iconPhrase.lowercased().contains("sunny")
					}, id: \.epochDateTime) { weather in
						NavigationLink(destination: HourDetailView(weather: weather)) {
							HStack {
								Image(systemName: weather.iconPhrase.lowercased().contains("sunny") ? "sun.max.fill" : "cloud.fill")
									.foregroundColor(weather.iconPhrase.lowercased().contains("sunny") ? .yellow : .gray)
								Text("\(String.formatAsInteger(weather.temperature)) \(weather.temperatureUnit)")
								VStack(alignment: .leading) {
									Text(weather.iconPhrase)
									Text(weather.dateTime)
								}
							}
						}
					}
				}
				.navigationTitle("Hourly Weather")
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						Button(action: {
							hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
						}) {
							Image(systemName: "arrow.clockwise")
								.imageScale(.medium)
						}
					}
					ToolbarItem(placement: .navigationBarTrailing) {
						Toggle(isOn: $onlyShowSunny) {
							Image(systemName: "sun.max.fill")
								.imageScale(.large)
								.frame(width: 44, height: 44)
						}
						.labelsHidden()
						.tint(.blue)
					}
				}
			}
		}
		.onChange(of: user.locationKey) { oldValue, newValue in
			if !appSettings.isTestDataEnabled && oldValue != newValue && !newValue.isEmpty {
				Task {
					await hourlyWeatherStore.loadWeatherData(locationKey: newValue)
				}
			}
		}
	}
}
