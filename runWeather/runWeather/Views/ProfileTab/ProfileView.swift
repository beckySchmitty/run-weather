//
//  ProfileView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var user: User
    @EnvironmentObject var locationStore: LocationStore
    @State private var inputZipCode: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Spacer()
            Text(user.zipCode.isEmpty ? "" : "Zip Code: \(user.zipCode)")
            Text(user.locationKey.isEmpty ? "" : "Location Key: \(user.locationKey)")
            Spacer()
            Text(user.zipCode.isEmpty ? "Please enter your Zip Code" : "Edit Zip Code")
            TextField("", text: $inputZipCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 200)
                .onSubmit {
                    asyncSubmit()
                }
            Spacer()
        }
        .onAppear {
            inputZipCode = user.zipCode
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
        Task {
            do {
                if let locationKey = try await locationStore.fetchLocationKey(for: user.zipCode) {
                    user.locationKey = locationKey
                    print(">>>> setting locationKey: \(locationKey)")
                } else {
                    alertMessage = "Failed to fetch location key"
                    showAlert = true
                }
            } catch {
                alertMessage = "Error fetching location key: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}
