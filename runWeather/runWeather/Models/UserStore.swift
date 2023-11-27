//
//  UserModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//
import Foundation

@MainActor
class UserStore: ObservableObject {
	@Published var user: UserModel
	@Published var zipCode: String
	@Published var locationKey: String
	@Published var localizedName: String
	@Published var isTestDataEnabled: Bool
	@Published var currentError: Error?

	init(user: UserModel = UserModel()) {
		self.user = user
		self.zipCode = user.zipCode
		self.locationKey = user.locationKey
		self.localizedName = user.localizedName
		self.isTestDataEnabled = user.isTestDataEnabled
		self.user.preferences = loadPreferences()
	}

	func loadPreferences() -> Preferences {
		// Adjust the path as needed for your app structure
		let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserModelPreferences.json")

		do {
			if let fileUrl = fileUrl, let data = try? Data(contentsOf: fileUrl) {
				let preferences = try JSONDecoder().decode(Preferences.self, from: data)

				return preferences
			}
		} catch {
			print("Error loading preferences: \(error)")
		}
		return Preferences()
	}

	func savePreferences() {
		//		// Force an error for testing
		//		do {
		//				throw TestError.forcedError
		//		} catch {
		//				currentError = error
		//				print("Test Error: \(error)")
		//				return
		//		}
		guard let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("UserModelPreferences.json") else { return }

		do {
			let fileManager = FileManager.default
			if !fileManager.fileExists(atPath: fileUrl.path) {
				// If the file does not exist, create it
				fileManager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
			}

			let jsonData = try JSONEncoder().encode(user.preferences)
			try jsonData.write(to: fileUrl, options: .atomicWrite)
			currentError = nil
			print("Saving preferences: \(user.preferences)")
		} catch {
			currentError = error
			print("Error saving preferences: \(error)")
		}
	}
}
