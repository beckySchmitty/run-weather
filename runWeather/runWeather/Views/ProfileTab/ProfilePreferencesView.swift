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
			VStack(alignment: .leading) {
				VStack {
					Text("Preferences")
						.font(.title)
					Text("Set minimum temperature and maximum precipitation level.")
						.font(.subheadline)
				}
				.padding()
				HStack {
					TemperatureSelectView(selectedTemperature: $userStore.user.preferences.selectedTemperature)
					PrecipitationSelectView(selectedPrecipitation: $userStore.user.preferences.selectedPrecipitation)
				}
				Spacer()
				Button("Save") {
					userStore.savePreferences()
				}
				.buttonStyle(.bordered)
				.frame(maxWidth: .infinity, alignment: .center) // This line centers the button
				Spacer()

				.alert(isPresented: $showAlert) {
					Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
				}
			}
			.padding()
		}
	}
}
