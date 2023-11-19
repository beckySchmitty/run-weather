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
				if newValue {
					TestDataLoader.setTestData(user: user, store: hourlyWeatherStore)
				} else {
					TestDataLoader.emptyTestData(user: user, store: hourlyWeatherStore)
				}
			}
	}
}
