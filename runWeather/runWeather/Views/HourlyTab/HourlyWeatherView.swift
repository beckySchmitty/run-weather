//
//  HourlyWeatherView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//
//

import SwiftUI

struct HourlyWeatherView: View {
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
	@ObservedObject var userStore: UserStore
	@State var isFilteredByUserPref = false
	@State private var isAnimating = false

	var body: some View {
		NavigationStack {
			if userStore.isTestDataEnabled == false && userStore.locationKey.isEmpty {
				NoWeatherDataView(userStore: userStore)
			} else {
				WeatherListView(userStore: userStore, isFilteredByUserPref: $isFilteredByUserPref)
					.navigationTitle("Hourly Weather")
					.toolbar {
						if !userStore.isTestDataEnabled {
							ToolbarItem(placement: .navigationBarLeading) {
								Button(action: {
									isAnimating = true
									withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
										self.isAnimating = true
									}

									Task {
										await hourlyWeatherStore.loadWeatherData(locationKey: userStore.locationKey)
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
						}
						ToolbarItem(placement: .navigationBarTrailing) {
							HStack {
								Spacer()
								Toggle(isOn: $isFilteredByUserPref) {
									Image(systemName: "sparkles")
										.imageScale(.large)
								}
								.labelsHidden()
								.tint(.blue)
							}
							.padding(.trailing, 10)
						}
					}						}
		}
		.alert(hourlyWeatherStore.errorMessage ?? "Error", isPresented: $hourlyWeatherStore.hasError) {
			Button("OK", role: .cancel) { }
		} message: {
			Text(hourlyWeatherStore.errorMessage ?? "An unknown error occurred.")
		}
	}
}
