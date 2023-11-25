//
//  MockUser.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/21/23.
//

import XCTest
@testable import runWeather

@MainActor
class MockUser: User {
		override init(zipCode: String = "", locationKey: String = "", localizedName: String = "", isTestDataEnabled: Bool = false) {
				super.init(zipCode: zipCode, locationKey: locationKey, localizedName: localizedName, isTestDataEnabled: isTestDataEnabled)

				self.zipCode = "43015"
				self.locationKey = "MockLocationKey"
				self.localizedName = "MockLocalizedName"
				self.isTestDataEnabled = false
				self.preferences = Preferences(selectedTemperature: "33°F", selectedPrecipitation: "< 40%")
		}
}

@MainActor
class UserTests: XCTestCase {
		func testMockUserPreferences() {
				let mockUser = MockUser()

				XCTAssertEqual(mockUser.preferences.selectedTemperature, "33°F")
				XCTAssertEqual(mockUser.preferences.selectedPrecipitation, "< 40%")
		}
}
