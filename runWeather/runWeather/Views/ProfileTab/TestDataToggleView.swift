//
//  TestDataToggleView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/19/23.
//

import SwiftUI

struct TestDataToggleView: View {
		@ObservedObject var userStore: UserStore
		@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore

		var body: some View {
				Toggle("Enable Test Data", isOn: $userStore.isTestDataEnabled)
						.padding()
						.toggleStyle(SwitchToggleStyle(tint: Color("toggleColor")))
						.onChange(of: userStore.isTestDataEnabled) { _, newValue in
								print("Toggle changed: \(newValue ? "ON" : "OFF")")
								if newValue {
										Task { @MainActor in
												await TestDataLoader.setTestData(userStore: userStore, store: hourlyWeatherStore)
										}
								} else {
										if userStore.autoDisableTestData {
												TestDataLoader.disableUserTestData(userStore: userStore)
										} else {
												TestDataLoader.emptyTestData(userStore: userStore, store: hourlyWeatherStore)
										}
								}
						}
						.accessibilityIdentifier("testDataToggle")
		}
}
