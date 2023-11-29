//
//  TestDataToggleView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/19/23.
//

import SwiftUI

struct TestDataToggleView: View {
	@ObservedObject var userStore: UserStore
	@Binding var isTestDataEnabled: Bool
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore

	var body: some View {
		Toggle("Enable Test Data", isOn: $isTestDataEnabled)
			.padding()
			.toggleStyle(SwitchToggleStyle(tint: Color("toggleColor")))
			.onChange(of: isTestDataEnabled) { _, newValue in
				print("Toggle changed: \(newValue ? "ON" : "OFF")")
				if newValue {
					Task {
						await TestDataLoader.setTestData(userStore: userStore, store: hourlyWeatherStore)
					}
				} else {
					TestDataLoader.emptyTestData(userStore: userStore, store: hourlyWeatherStore)
				}
			}
			.accessibilityIdentifier("testDataToggle")
	}
}
