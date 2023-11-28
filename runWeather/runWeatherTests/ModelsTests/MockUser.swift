//
//  MockUserStore.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/21/23.
//

import XCTest
@testable import runWeather

@MainActor
class MockUserStore: UserStore {
	init() {
		let mockUserModel = UserModel(
			zipCode: "43015",
			locationKey: "MockLocationKey",
			localizedName: "MockLocalizedName",
			isTestDataEnabled: false,
			preferences: Preferences(selectedTemperature: "40", selectedPrecipitation: "20")
		)
		super.init(user: mockUserModel)
	}
}
