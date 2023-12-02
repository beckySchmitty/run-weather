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
		//			using "prototype" as it is a better user facing term
		Toggle("Enable Prototype", isOn: $userStore.isTestDataEnabled)
			.padding()
			.toggleStyle(SwitchToggleStyle(tint: Color("toggleColor")))
			.onChange(of: userStore.isTestDataEnabled) { _, newValue in
				if newValue {
					Task { @MainActor in
						//											set user test data if toggled ON
						await TestDataLoader.setTestData(userStore: userStore, store: hourlyWeatherStore)
					}
				} else {
					//					swiftlint:disable indentation_width
					/*
					 disable user specific test data
					 this covers the case where a user left the toggle ON 
					 but made a successful call to a new ZIP code
					 */										if userStore.autoDisableTestData {
						 TestDataLoader.disableUserTestData(userStore: userStore)
					 } else {
						 //											empty test data if toggled OFF
						 TestDataLoader.emptyTestData(userStore: userStore, store: hourlyWeatherStore)
					 }
				}
			}
			.accessibilityIdentifier("testDataToggle")
	}
}
//					swiftlint:enable indentation_width
