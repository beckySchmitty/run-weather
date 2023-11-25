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
	@Published var isTestDataEnabled: Bool
	@Published var preferences = Preferences()

	init(zipCode: String = "", locationKey: String = "", localizedName: String = "", isTestDataEnabled: Bool = false) {
		self.zipCode = zipCode
		self.locationKey = locationKey
		self.localizedName = localizedName
		self.isTestDataEnabled = isTestDataEnabled
		self.preferences = User.loadPreferences()
	}

	private static func loadPreferences() -> Preferences {
		//		swiftlint:disable:next line_length
		guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return Preferences() }
		let fileUrl = documentDirectoryUrl.appendingPathComponent("UserModelPreferences.json")

		do {
			let data = try Data(contentsOf: fileUrl)
			let preferences = try JSONDecoder().decode(Preferences.self, from: data)
			return preferences
		} catch {
			print("Error loading preferences: \(error)")
			return Preferences() // Return default preferences if loading fails
		}
	}
}
