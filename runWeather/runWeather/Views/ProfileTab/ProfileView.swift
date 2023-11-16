////
////  ProfileView.swift
////  runWeather
////
////  Created by Becky Schmitthenner on 11/14/23.
////

//import SwiftUI
//
//struct ProfileView: View {
//	@ObservedObject var user: User
//	@EnvironmentObject var locationStore: LocationStore
//	@EnvironmentObject var hourlyWeatherStore: HourlyWeatherStore
//	@EnvironmentObject var appSettings: AppSettings
//	@State private var inputZipCode: String = ""
//	@State private var showAlert = false
//	@State private var alertMessage = ""
//	
//	var body: some View {
//		VStack {
//			// Profile image and details
//			ProfileHeaderView(user: user)
//
//			// Zip Code TextField
//			Spacer()
//			GeometryReader { geometry in
//				HStack {
//					Spacer()
//					
//					TextField("Zip Code", text: $inputZipCode)
//						.padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
//						.background(Color.white)
//						.cornerRadius(10)
//						.overlay(
//							RoundedRectangle(cornerRadius: 10)
//								.stroke(Color.gray, lineWidth: 1)
//						)
//						.shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
//						.keyboardType(.numberPad)
//						.multilineTextAlignment(.center)
//						.frame(width: geometry.size.width / 2)
//					Spacer()
//				}
//			}
//			.frame(height: 50)
//			.onSubmit {
//				asyncSubmit()
//			}
//			Spacer()
//			List {
//				ProfileRow(icon: "gear", title: "Settings")
//				ProfileRow(icon: "key", title: "Location Key")
//				ProfileRow(icon: "bell.fill", title: "Notifications")
//				ProfileRow(icon: "envelope.fill", title: "Messages")
//			}
//			.listStyle(PlainListStyle())
//			.frame(maxWidth: .infinity, maxHeight: 300)
//			Spacer()
//			
//			Toggle("Enable Test Data", isOn: $appSettings.isTestDataEnabled)
//				.onChange(of: appSettings.isTestDataEnabled) { newValue in
//					if newValue {
//						loadTestData()
//					} else {
//						// Optionally reload real data if test data is turned off
//						if !user.locationKey.isEmpty {
//							Task {
//								await hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
//							}
//						}
//					}
//				}
//				.padding()
//		}
//		.onAppear {
//			inputZipCode = user.zipCode
//		}
//		.alert(isPresented: $showAlert) {
//			Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//		}
//		.frame(maxHeight: .infinity)
//		
//	}
//	
//	private func asyncSubmit() {
//		Task {
//			await findAndSetLocation(zipCode: inputZipCode)
//		}
//	}
//	
//	private func findAndSetLocation(zipCode: String) async {
//		if validateAndAssignZipCode() {
//			await fetchLocationKeyAndUpdateUser()
//		}
//	}
//	
//	private func validateAndAssignZipCode() -> Bool {
//		let trimmedZipCode = inputZipCode.trimmingCharacters(in: .whitespaces)
//		if trimmedZipCode.count == 5 && trimmedZipCode.allSatisfy(\.isNumber) {
//			user.zipCode = trimmedZipCode
//			inputZipCode = ""
//			return true
//		} else {
//			alertMessage = "Invalid Zip Code"
//			showAlert = true
//			inputZipCode = ""
//			return false
//		}
//	}
//	
//	private func fetchLocationKeyAndUpdateUser() async {
//		do {
//			if let locationKey = try await locationStore.fetchLocationKey(for: user.zipCode) {
//				user.locationKey = locationKey
//			} else {
//				alertMessage = "Failed to fetch location key"
//				showAlert = true
//			}
//		} catch {
//			alertMessage = "Error fetching location key: \(error.localizedDescription)"
//			showAlert = true
//		}
//	}
//	private func loadTestData() {
//		if appSettings.isTestDataEnabled {
//			TestDataLoader.setTestUserDetails(user: user)
//			TestDataLoader.loadWeatherTestData(into: hourlyWeatherStore)
//		} else {
//			// placeholder
//		}
//	}
//}

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
				ScrollView {
						VStack {
								ProfileHeaderView(user: user)

								TextField("Zip Code", text: $inputZipCode)
										.padding()
										.background(Color.white)
										.cornerRadius(10)
										.overlay(
												RoundedRectangle(cornerRadius: 10)
														.stroke(Color.gray, lineWidth: 1)
										)
										.shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
										.keyboardType(.numberPad)
										.multilineTextAlignment(.center)
										.padding([.leading, .trailing], 40) // Use padding to adjust the width
										.onSubmit {
												asyncSubmit()
										}

								Toggle("Enable Test Data", isOn: $appSettings.isTestDataEnabled)
										.onChange(of: appSettings.isTestDataEnabled) { newValue in
												if newValue {
														loadTestData()
												} else {
														// Optionally reload real data if test data is turned off
														if !user.locationKey.isEmpty {
																Task {
																		await hourlyWeatherStore.loadWeatherData(locationKey: user.locationKey)
																}
														}
												}
										}
										.padding()

								List {
										ProfileRow(icon: "gear", title: "Settings")
										ProfileRow(icon: "key", title: "Location Key")
										ProfileRow(icon: "bell.fill", title: "Notifications")
										ProfileRow(icon: "envelope.fill", title: "Messages")
								}
								.listStyle(PlainListStyle())
						}
						.frame(maxWidth: .infinity)
				}
				.alert(isPresented: $showAlert) {
						Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
				}
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
		} else {
			// placeholder
		}
	}
}
