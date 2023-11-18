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

	@Environment(\.colorScheme) var colorScheme

	var body: some View {
		VStack {
			Spacer()
			ProfileHeaderView(user: user)
			ZipCodeView(inputZipCode: $inputZipCode, onSubmit: asyncSubmit)
			ScrollView {
				VStack {
					ProfilePreferencesView()
					Toggle("Dark Mode", isOn: $user.isDarkModeEnabled)
						.onChange(of: user.isDarkModeEnabled) { _, newValue in
							UserDefaults.standard.set(newValue, forKey: "isDarkModeEnabled")
						}
						.padding()
					Toggle("Enable Test Data", isOn: $user.isTestDataEnabled)
						.padding()
						.onChange(of: user.isTestDataEnabled) { _, newValue in
							if newValue {
								TestDataLoader.setTestData(user: user, store: hourlyWeatherStore)
							} else if newValue == false {
								TestDataLoader.emptyTestData(user: user, store: hourlyWeatherStore)
							} else {
								alertMessage = "Issue with test data. Please try again."
								showAlert = true
							}
						}
				}
			}
		}
		.background(user.isDarkModeEnabled ? Color("backgroundBlue") : Color.gray)
		.alert(isPresented: $showAlert) {
			Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
		}
		.frame(maxHeight: .infinity)
	}

	private func asyncSubmit() async {
		// do not use async let; loadWeatherData needs location key set first TODO refactor logic
		_ = await verifyZipAndGetLocation(zipCode: inputZipCode)
		_ = await loadWeatherDataForUser()

		if let errorMessage = hourlyWeatherStore.errorMessage ?? self.locationStore.errorMessage {
			setAlert(with: errorMessage)
		}
	}

	private func verifyZipAndGetLocation(zipCode: String) async {
		if verifyAndSetZipCode() {
			await getLocationKey()
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


	private func loadWeatherDataForUser() async {
		await hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
		if hourlyWeatherStore.hasError, let errorMessage = hourlyWeatherStore.errorMessage {
			alertMessage = errorMessage
			showAlert = true
		}
	}

	@MainActor
	private func setAlert(with message: String) {
		self.alertMessage = message
		self.showAlert = true
	}
}
