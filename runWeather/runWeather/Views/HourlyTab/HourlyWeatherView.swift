//
//  HourlyWeatherView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct HourlyWeatherView: View {
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
	@ObservedObject var user: User
	@State var onlyShowSunny = false
	@State private var isAnimating = false

	var filteredWeather: [HourlyWeather] {
		onlyShowSunny ? hourlyWeatherStore.hourlyWeather.filter { $0.iconPhrase.lowercased().contains("sunny") }
		: hourlyWeatherStore.hourlyWeather
	}

	var body: some View {
		NavigationStack {
			if user.isTestDataEnabled == false && user.locationKey.isEmpty {
				NoWeatherDataView(user: user)
			} else {
				WeatherListView(filteredWeather: filteredWeather, user: user)
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
									Image(systemName: "sparkles")
										.imageScale(.large)
								}
								.labelsHidden()
								.tint(.blue)
							}
							.padding(.trailing, 10)
						}
					}
			}
		}
		.alert(hourlyWeatherStore.errorMessage ?? "Error", isPresented: $hourlyWeatherStore.hasError) {
			Button("OK", role: .cancel) { }
		} message: {
			Text(hourlyWeatherStore.errorMessage ?? "An unknown error occurred.")
		}
	}
}
