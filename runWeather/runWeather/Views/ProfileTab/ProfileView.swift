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
		@EnvironmentObject var appSettings: AppSettings
		@State private var inputZipCode: String = ""
		@State private var showAlert = false
		@State private var alertMessage = ""

		var body: some View {
				VStack {
						ZStack {
								HStack {
										Image(appSettings.isTestDataEnabled ? "profile_tKelce" : "profile")
												.resizable()
												.aspectRatio(contentMode: .fill)
												.frame(width: 100, height: 100)
												.clipShape(Circle())
												.overlay(Circle().stroke(Color.white, lineWidth: 4))
										Text(appSettings.isTestDataEnabled ? "Travis Kelce" : "User")
												.font(.title)
												.foregroundColor(.white)
										Text("Zip Code: \(user.zipCode)")
												.font(.subheadline)
												.foregroundColor(.white)
										Text("Location Key: \(user.locationKey)")
												.font(.subheadline)
												.foregroundColor(.white)
								}
						}
					Spacer()


						// Using GeometryReader for Zip Code text field layout
						GeometryReader { geometry in
								HStack {
										Spacer()

										TextField("Zip Code", text: $inputZipCode)
												.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
												.background(Color.white)
												.cornerRadius(10)
												.overlay(
														RoundedRectangle(cornerRadius: 10)
																.stroke(Color.gray, lineWidth: 1)
												)
												.shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
												.keyboardType(.numberPad)
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
										// Add your rows here
										Text("row")
										Text("row")

										// Dark Mode Toggle
										Toggle("Dark Mode", isOn: Binding(
												get: { user.isDarkModeEnabled },
												set: { user.updateDarkModePreference(to: $0) }
										))
										.padding()

										// Test Data Toggle
										Toggle("Enable Test Data", isOn: $appSettings.isTestDataEnabled)
												.padding()
								}
						}

				}
				.onAppear {
						inputZipCode = user.zipCode
						checkTestDataSetting()
				}
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
						alertMessage = "Invalid Zip Code"
						showAlert = true
						inputZipCode = ""
						return false
				}
		}

		private func fetchLocationKeyAndUpdateUser() async {
				do {
						if let locationKey = try await locationStore.fetchLocationKey(for: user.zipCode) {
								user.locationKey = locationKey
						} else {
								alertMessage = "Failed to fetch location key"
								showAlert = true
						}
				} catch {
						alertMessage = "Error fetching location key: \(error.localizedDescription)"
						showAlert = true
				}
		}

		private func loadTestData() {
				if appSettings.isTestDataEnabled {
						TestDataLoader.setTestUserDetails(user: user)
						TestDataLoader.loadWeatherTestData(into: hourlyWeatherStore)
				}
		}

		private func checkTestDataSetting() {
				if appSettings.isTestDataEnabled {
						loadTestData()
				} else if !user.locationKey.isEmpty {
						Task {
								await hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
						}
				}
		}
}
