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
					TestDataToggleView(userStore: userStore)
				}
			} else {
				HStack {
					//											Landscape
					VStack {
						ProfileHeaderView(userStore: userStore)
						ZipCodeView(inputZipCode: $inputZipCode, onSubmit: asyncSubmit)
						TestDataToggleView(userStore: userStore)
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
		//		swiftlint:disable indentation_width
		/*
		 asyncSubmit() is called once a user enters their ZIP Code. Here's the TLDR:
		 First, verify it's a valid ZIP code.
		 Then, call the third-party API to get the Location Key.
		 Next, use Location Key to call the third-party API for the Hourly Weather
		 During all this, errors are handled and data is saved to UserStore, LocationStore, and HourlyWeatherStore.
		 */
		guard await verifyZipAndGetLocation(zipCode: inputZipCode) else {
			return
		}
		do {
			//			set Hourly Weather
			try await loadWeatherDataForUser()
			//			Clear test user data
			userStore.autoDisableTestData = true
			TestDataLoader.disableUserTestData(userStore: userStore)
		} catch let error as URLError where error.code == .notConnectedToInternet {
			self.alertMessage = "Network connection is unavailable. Please check your internet settings."
			self.showAlert = true
		} catch {
			self.alertMessage = "An unexpected error occurred: \(error.localizedDescription)"
			self.showAlert = true
		}
	}
	//					swiftlint:enable indentation_width


	// load hourly weather
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
			//			if valid ZIP code, call the API to get the Location Key
			return await getLocationKey()
		} else {
			return false
		}
	}

	//	verify ZIP code, save it to UserStore
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

	//	call API for location key & save location key
	private func getLocationKey() async -> Bool {
		do {
			let locationKey = try await locationStore.fetchLocationKey(for: userStore.zipCode)
			userStore.locationKey = locationKey
			return true
		} catch let error as LocationError {
			switch error {
			case .locationNotFound:
				//						clear user zip code if error
				userStore.zipCode = ""
				setAlert(with: error)
			default:
				//						clear user zip code if error
				setAlert(with: error)
			}
			return false
		} catch {
			// catch-all block that handles any other errors
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
