//
//  ProfilePreferencesView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/18/23.
//

import SwiftUI

struct ProfilePreferencesView: View {
	@ObservedObject var userStore: UserStore
	@State private var showErrorSheet = false
	let temperatures = Array(stride(from: 10, through: 100, by: 1)).map { "\($0)°F" }
	let precipitationLevels = ["0 %", "< 20%", "< 40%", "< 60%", "< 80%"]

	var body: some View {
		Spacer()
		ScrollView {
			Text("Preferences")
				.font(.title)
			Text("Customize preferred conditions for your outdoor lifestyle")
			TemperatureSelectView(selectedTemperature: $userStore.user.preferences.selectedTemperature)
			PrecipitationSelectView(selectedPrecipitation: $userStore.user.preferences.selectedPrecipitation)
			Button("Save Preferences") {
				userStore.savePreferences()
				showErrorSheet = userStore.currentError is PreferencesError
			}
			.padding()
			.buttonStyle(.bordered)
			.sheet(isPresented: $showErrorSheet) {
				if let error = userStore.currentError as? PreferencesError {
					ErrorSheetView(errorMessage: error.localizedDescription, isPresented: $showErrorSheet)
						.presentationDetents([.medium]) // Use this to set the half-sheet size
				} else {
					// This else block could be removed if only showing preferences errors
					ErrorSheetView(errorMessage: "An unknown error occurred", isPresented: $showErrorSheet)
				}
			}
		}
	}
}
