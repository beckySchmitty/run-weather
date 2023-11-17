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
	@State private var isAnimating = false

	var filteredWeather: [HourlyWeather] {
		onlyShowSunny ? hourlyWeatherStore.hourlyWeather.filter { $0.iconPhrase.lowercased().contains("sunny") }
		: hourlyWeatherStore.hourlyWeather
	}

	var body: some View {
		NavigationStack {
			if user.locationKey.isEmpty {
				NoWeatherDataView()
			} else {
				List(filteredWeather, id: \.epochDateTime) { weather in
					HourlyWeatherRow(weather: weather)
				}
				.navigationTitle("Hourly Weather")
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						Button(action: {
							isAnimating = true

							withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
								// Explicitly trigger the animation
								self.isAnimating = true
							}

							Task {
								await hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
								withAnimation {
									self.isAnimating = false
								}
							}
						}, label: {
							Image(systemName: "arrow.clockwise")
								.imageScale(.medium)
								.scaleEffect(isAnimating ? 3 : 1)
								.rotationEffect(.degrees(isAnimating ? 360 : 0))
						})
						.buttonStyle(.plain)
					}
					ToolbarItem(placement: .navigationBarTrailing) {
						HStack {
							Spacer()
							Toggle(isOn: $onlyShowSunny) {
								Image(systemName: "sun.max.fill")
							}
							.labelsHidden()
							.tint(.blue)
						}
						.padding(.trailing, 10)
					}
				}
			}
		}
		.onChange(of: user.locationKey) { _, newValue in
			if !appSettings.isTestDataEnabled && !newValue.isEmpty {
				Task {
					await hourlyWeatherStore.loadWeatherData(locationKey: newValue)
				}
			}
		}
	}
}
