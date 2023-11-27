//
//  TestDataToggleView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/19/23.
//

import SwiftUI

struct TestDataToggleView: View {
	@ObservedObject var user: User
	@Binding var isTestDataEnabled: Bool
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore

	var body: some View {
		Toggle("Enable Test Data", isOn: $isTestDataEnabled)
			.padding()
			.onChange(of: isTestDataEnabled) { _, newValue in
				print("###### Toggle changed: \(newValue ? "ON" : "OFF")")
				if newValue {
					Task {
						await TestDataLoader.setTestData(user: user, store: hourlyWeatherStore)
					}
				} else {
					TestDataLoader.emptyTestData(user: user, store: hourlyWeatherStore)
				}
			}
			.accessibilityIdentifier("testDataToggle")
	}
}
