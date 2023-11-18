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
	@Environment(\.colorScheme) var colorScheme
	@State private var inputZipCode: String = ""
	@State private var showAlert = false
	@State private var alertMessage = ""

	var body: some View {
		VStack {
			Spacer()
			VStack {
				ProfileHeaderView(user: user)
			}
			GeometryReader { geometry in
				HStack {
					Spacer()
					TextField("Zip Code", text: $inputZipCode)
						.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
						.background(Color.white)
						.cornerRadius(10)
						.overlay(
							RoundedRectangle(cornerRadius: 10)
								.stroke(Color("backgroundBlue"), lineWidth: 2)
						)
						.shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
						.keyboardType(.numberPad)
						.foregroundColor(.black)
						.multilineTextAlignment(.center)
						.frame(width: geometry.size.width / 2)

					Spacer()
				}
			}
			.frame(height: 50)
			.onSubmit {
				asyncSubmit()
			}
			ScrollView {
				VStack {
					Text("row")
					Text("row")
					Toggle("Dark Mode", isOn: $user.isDarkModeEnabled)
						.onChange(of: user.isDarkModeEnabled) { oldValue, newValue in
								UserDefaults.standard.set(newValue, forKey: "isDarkModeEnabled")
						}
						.padding()
					Toggle("Enable Test Data", isOn: $user.isTestDataEnabled)
						.padding()
						.onChange(of: user.isTestDataEnabled) { oldValue, newValue in
							if newValue {
								loadTestData()
							} else {
								alertMessage = "Issue setting test data. Please try again."
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

	private func asyncSubmit() {
		Task {
			await findAndSetLocation(zipCode: inputZipCode)
		}
	}

	private func findAndSetLocation(zipCode: String) async {
		if validateAndAssignZipCode() {
			await fetchLocationKeyAndUpdateUser()
		}
	}

	private func validateAndAssignZipCode() -> Bool {
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

	private func fetchLocationKeyAndUpdateUser() async {
		do {
			let locationKey = try await locationStore.fetchLocationKey(for: user.zipCode)
			user.locationKey = locationKey
		} catch LocationError.invalidURL {
			alertMessage = "There was an error processing your request. Please try again or contact support."
			showAlert = true
		} catch LocationError.serverError(let statusCode) {
			alertMessage = "Please try again later. The server responded with status code: \(statusCode)."
			showAlert = true
		} catch LocationError.decodingError(let underlyingError) {
			alertMessage = "There was a problem decoding the data: \(underlyingError.localizedDescription). Please contact support."
			showAlert = true
		} catch {
			alertMessage = "An unknown error occurred: \(error.localizedDescription). Please try again."
			showAlert = true
		}
	}


	private func loadTestData() {
			TestDataLoader.setTestUserDetails(user: user)
			TestDataLoader.loadWeatherTestData(into: hourlyWeatherStore)
	}
}
