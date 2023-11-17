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
	@Published var isDarkModeEnabled: Bool

	init(zipCode: String = "", locationKey: String = "", localizedName: String = "") {
		self.zipCode = zipCode
		self.locationKey = locationKey
		self.localizedName = localizedName
		self.isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
	}


	func updateDarkModePreference(to newValue: Bool) {
		isDarkModeEnabled = newValue
		print("******* newValue \(newValue)")
		UserDefaults.standard.set(newValue, forKey: "isDarkModeEnabled")
	}
}
