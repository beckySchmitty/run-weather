////////
////////  ProfileView.swift
////////  runWeather
////////
////////  Created by Becky Schmitthenner on 11/14/23.
////////

import SwiftUI


struct ProfileView: View {
	@ObservedObject var user: User
	@EnvironmentObject var locationStore: LocationStore
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
	@State private var inputZipCode: String = ""
	@State private var showAlert = false
	@State private var alertMessage = ""
	@Environment(\.colorScheme)
	var systemColorScheme

	var body: some View {
		VStack {
			ProfileHeaderView(user: user)
			ZipCodeView(inputZipCode: $inputZipCode, onSubmit: asyncSubmit)
			ScrollView {
				VStack {
					ProfilePreferencesView()
					DarkModeToggleView(user: user, isDarkModeEnabled: $user.isDarkModeEnabled)
					TestDataToggleView(user: user, isTestDataEnabled: $user.isTestDataEnabled)
				}
			}
		}
		.background(user.isDarkModeEnabled ? Color("backgroundBlue") : Color.gray)
		.alert(isPresented: $showAlert) {
			Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
		}
		.onAppear {
			updateDarkModePreference()
		}
		.onChange(of: systemColorScheme) { _, _ in
			updateDarkModePreference()
		}
		.frame(maxHeight: .infinity)
	}

	private func updateDarkModePreference() {
		guard !user.hasSetDarkMode else { return }
		let isSystemDarkMode = systemColorScheme == .dark
		user.isDarkModeEnabled = isSystemDarkMode
	}
}

// Extension for Async Functions
extension ProfileView {
	//	set user and weather data
	private func asyncSubmit() async {
		//			location key must be saved to call loadWeatherData so do not use async let
		guard await verifyZipAndGetLocation(zipCode: inputZipCode) else {
			return
		}
		await loadWeatherDataForUser()
	}

	private func loadWeatherDataForUser() async {
		await hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
		if hourlyWeatherStore.hasError, let errorMessage = hourlyWeatherStore.errorMessage {
			alertMessage = errorMessage
			showAlert = true
		}
	}
}

// Extension for Validation and Error Handling
extension ProfileView {
	private func verifyZipAndGetLocation(zipCode: String) async -> Bool {
		if verifyAndSetZipCode() {
			await getLocationKey()
			return true
		} else {
			return false
		}
	}

	private func verifyAndSetZipCode() -> Bool {
		let trimmedZipCode = inputZipCode.trimmingCharacters(in: .whitespaces)
		if trimmedZipCode.count == 5 && trimmedZipCode.allSatisfy(\.isNumber) {
			user.zipCode = trimmedZipCode
			inputZipCode = ""
			return true
		} else {
			alertMessage = "Invalid Zip Code. Please try again."
			showAlert = true
			inputZipCode = ""
			return false
		}
	}

	private func getLocationKey() async {
		do {
			let locationKey = try await locationStore.fetchLocationKey(for: user.zipCode)
			user.locationKey = locationKey
		} catch let error as LocationError {
			switch error {
			case .invalidURL:
				alertMessage = "There was an error processing your request. Please try again or contact support."
			case .serverError(let statusCode):
				alertMessage = "Please try again later. The server responded with status code: \(statusCode)."
			case .decodingError(let underlyingError):
				alertMessage = "There was a problem decoding the data: \(underlyingError.localizedDescription). Please contact support."
			case .other:
				alertMessage = "other"
			}
			showAlert = true
		} catch {
			alertMessage = "An unknown error occurred: \(error.localizedDescription)"
			showAlert = true
		}
	}

	@MainActor
	private func setAlert(with message: String) {
		self.alertMessage = message
		self.showAlert = true
	}
}
