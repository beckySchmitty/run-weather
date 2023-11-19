//
//  UserModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//
import Foundation

@MainActor
class User: ObservableObject {
	@Published var zipCode: String
	@Published var locationKey: String
	@Published var localizedName: String
	@Published var hasSetDarkMode = false
	@Published var isDarkModeEnabled: Bool
	@Published var isTestDataEnabled: Bool

	init(zipCode: String = "", locationKey: String = "", localizedName: String = "", isTestDataEnabled: Bool = false) {
		self.zipCode = zipCode
		self.locationKey = locationKey
		self.localizedName = localizedName
		self.isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
		self.isTestDataEnabled = isTestDataEnabled
	}

	//	handles dark mode from iOS device and dark mode from this app
	func updateDarkModePreference(to newValue: Bool) {
		isDarkModeEnabled = newValue
		hasSetDarkMode = true
		UserDefaults.standard.set(newValue, forKey: "isDarkModeEnabled")
	}
}
