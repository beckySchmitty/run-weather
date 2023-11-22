//
//  MockUser.swift
//  runWeatherTests
//
//  Created by Becky Schmitthenner on 11/21/23.
//

import XCTest
@testable import runWeather

class MockUser: User {
		override init(zipCode: String = "", locationKey: String = "", localizedName: String = "", isTestDataEnabled: Bool = false) {
				super.init(zipCode: zipCode, locationKey: locationKey, localizedName: localizedName, isTestDataEnabled: isTestDataEnabled)

				// Set the mock user's properties with test data
				self.zipCode = "MockZipCode"
				self.locationKey = "MockLocationKey"
				self.localizedName = "MockLocalizedName"
				self.isTestDataEnabled = true // or false, depending on the test scenario
				// Optionally, set mock preferences if needed
		}

		// Override methods if necessary, for instance, to prevent actual file access
		override func loadPreferences() -> Preferences {
				// Return mock preferences or default preferences
				return Preferences() // Assuming Preferences is a struct with default values
		}
}
