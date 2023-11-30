//
//  ProfilePreferencesView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/18/23.
//

import SwiftUI

struct ProfilePreferencesView: View {
	@ObservedObject var userStore: UserStore
	@State private var showAlert = false
	@State private var alertMessage = ""
	let temperatures = Array(stride(from: 10, through: 100, by: 1)).map { "\($0)°F" }
	let precipitationLevels = ["0 %", "< 20%", "< 40%", "< 60%", "< 80%"]

	var body: some View {
		ScrollView {
			Text("Preferences")
				.font(.title)
			Text("No one likes running in the rain or cold. Set your minimum temperature and maximum precipitation level.")
			VStack(spacing: 6) {
				TemperatureSelectView(selectedTemperature: $userStore.user.preferences.selectedTemperature)
				PrecipitationSelectView(selectedPrecipitation: $userStore.user.preferences.selectedPrecipitation)
			}
			Button("Save Preferences") {
				userStore.savePreferences()
			}
			.padding(6)
			.buttonStyle(.bordered)
			.alert(isPresented: $showAlert) {
				Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
			}
		}
	}
}
