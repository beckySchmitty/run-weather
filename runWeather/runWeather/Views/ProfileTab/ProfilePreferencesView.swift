//
//  ProfilePreferencesView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/18/23.
//

import SwiftUI

struct ProfilePreferencesView: View {
	@ObservedObject var user: User
	let temperatures = Array(stride(from: 10, through: 100, by: 1)).map { "\($0)°F" }
	let precipitationLevels = ["0 %", "< 20%", "< 40%", "< 60%", "< 80%"]

	var body: some View {
		Spacer()
		ScrollView {
			Text("Preferences")
				.font(.title)
			Text("Customize preferred conditions for your outdoor lifestyle")
			TemperatureSelectView(selectedTemperature: $user.preferences.selectedTemperature)
			PrecipitationSelectView(selectedPrecipitation: $user.preferences.selectedPrecipitation)
			Button("Save Preferences") {
				savePreferences()
			}
			.padding()
			.buttonStyle(.bordered)
		}
	}

	private func savePreferences() {
//		swiftlint:disable:next line_length
	guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
		let fileUrl = documentDirectoryUrl.appendingPathComponent("UserModelPreferences.json")

		do {
			let fileManager = FileManager.default
			if !fileManager.fileExists(atPath: fileUrl.path) {
				// If the file does not exist, create it
				fileManager.createFile(atPath: fileUrl.path, contents: nil, attributes: nil)
			}

			let jsonData = try JSONEncoder().encode(user.preferences)
			try jsonData.write(to: fileUrl, options: .atomicWrite)
			print("***: \(String(data: jsonData, encoding: .utf8)!)")
			print("Preferences saved.")
		} catch {
			print("Error saving preferences: \(error)")
		}
	}
}
