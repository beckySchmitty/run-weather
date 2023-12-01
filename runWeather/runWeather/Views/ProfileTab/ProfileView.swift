////////
////////  ProfileView.swift
////////  runWeather
////////
////////  Created by Becky Schmitthenner on 11/14/23.
////////

import SwiftUI


struct ProfileView: View {
	@ObservedObject var userStore: UserStore
	@EnvironmentObject var locationStore: LocationStore
	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
	@State private var inputZipCode: String = ""
	@State private var showAlert = false
	@State private var alertMessage = ""
	@Environment(\.horizontalSizeClass)
	var horizontalSizeClass
	@Environment(\.verticalSizeClass)
	var verticalSizeClass


	var body: some View {
		ZStack {
			if horizontalSizeClass == .compact && verticalSizeClass == .regular {
				VStack {
					//					Portrait
					Spacer()
					ProfileHeaderView(userStore: userStore)
					Spacer()
					ZipCodeView(inputZipCode: $inputZipCode, onSubmit: asyncSubmit)
					ScrollView {
						VStack {
							ProfilePreferencesView(userStore: userStore)
						}
					}
					Spacer()
					TestDataToggleView(userStore: userStore, isTestDataEnabled: $userStore.isTestDataEnabled)
				}
			} else {
				HStack {
					//											Landscape
					VStack {
						ProfileHeaderView(userStore: userStore)
						ZipCodeView(inputZipCode: $inputZipCode, onSubmit: asyncSubmit)
						TestDataToggleView(userStore: userStore, isTestDataEnabled: $userStore.isTestDataEnabled)
					}
					ScrollView {
						VStack(alignment: .leading) {
							Spacer()
							ProfilePreferencesView(userStore: userStore)
						}
					}
				}
			}
		}
		.background(Color("backgroundBlue"))
		.alert(isPresented: $showAlert) {
			Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
		}
	}
}


// Extension for Async Functions
extension ProfileView {
	private func asyncSubmit() async {
		guard await verifyZipAndGetLocation(zipCode: inputZipCode) else {
			return
		}
		do {
			try await loadWeatherDataForUser()
		} catch let error as URLError where error.code == .notConnectedToInternet {
			self.alertMessage = "Network connection is unavailable. Please check your internet settings."
			self.showAlert = true
		} catch {
			self.alertMessage = "An unexpected error occurred: \(error.localizedDescription)"
			self.showAlert = true
		}
	}


	private func loadWeatherDataForUser() async throws {
		await hourlyWeatherStore.loadWeatherData(locationKey: userStore.locationKey)
		if hourlyWeatherStore.hasError, let errorMessage = hourlyWeatherStore.errorMessage {
			self.alertMessage = errorMessage
			self.showAlert = true
		}
	}
}

// Extension for Validation and Error Handling
extension ProfileView {
	private func verifyZipAndGetLocation(zipCode: String) async -> Bool {
		if verifyAndSetZipCode() {
			return await getLocationKey()
		} else {
			return false
		}
	}

	private func verifyAndSetZipCode() -> Bool {
		let trimmedZipCode = inputZipCode.trimmingCharacters(in: .whitespaces)
		if trimmedZipCode.count == 5 && trimmedZipCode.allSatisfy(\.isNumber) {
			userStore.zipCode = trimmedZipCode
			inputZipCode = ""
			return true
		} else {
			Task { @MainActor in
				self.alertMessage = "Invalid Zip Code. Please try again."
				self.showAlert = true
			}
			inputZipCode = ""
			return false
		}
	}

	private func getLocationKey() async -> Bool {
		do {
			let locationKey = try await locationStore.fetchLocationKey(for: userStore.zipCode)
			userStore.locationKey = locationKey
			return true
		} catch {
			setAlert(with: error)
			return false
		}
	}

	@MainActor
	private func setAlert(with error: Error) {
		if let locationError = error as? LocationError {
			self.alertMessage = locationError.localizedDescription
		} else {
			self.alertMessage = "An unknown error occurred: \(error.localizedDescription)"
		}
		self.showAlert = true
	}
}
