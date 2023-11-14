//
//  ZipCodeInputView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct ZipCodeInputView: View {
    @ObservedObject var user: User
    @State private var inputZipCode: String = ""
    @EnvironmentObject var locationStore: LocationStore
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(user.zipCode.isEmpty ? "Please enter your zip" : "Zip Code: \(user.zipCode)")
            Text(user.locationKey.isEmpty ? "No Location Key" : "Location Key: \(user.locationKey)")
            
            Spacer()
            
            TextField(user.zipCode.isEmpty ? "Enter Zip Code" : "Edit Zip Code", text: $inputZipCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 200)
                .onSubmit {
                    validateAndAssignZipCode()
                }
            
            Spacer()
        }
        .padding()
        .onAppear {
            // Set user zip code if already available
            inputZipCode = user.zipCode
        }
    }
    
    //    TODO: refactor / rename these functions to keep one clear action per func
    private func validateAndAssignZipCode() {
        let trimmedZipCode = inputZipCode.trimmingCharacters(in: .whitespaces)
        if trimmedZipCode.count == 5 && trimmedZipCode.allSatisfy(\.isNumber) {
            print("*********")
            user.zipCode = trimmedZipCode
            fetchLocationKeyAndUpdateUser()
            // Clear the input field
            inputZipCode = ""
        } else {
            // TODO: Handle invalid zip code (e.g., show an alert or clear the input)
            // Clear the input field
            inputZipCode = ""
        }
    }
    
    private func fetchLocationKeyAndUpdateUser() {
        Task {
            do {
                if let locationKey = try await locationStore.fetchLocationKey(for: user.zipCode) {
                    await MainActor.run {
                        print("Setting locationKey: \(locationKey)")
                        user.locationKey = locationKey
                    }
                } else {
                    print("Failed to fetch location key")
                }
            } catch {
                print("Error fetching location key: \(error)")
            }
        }
    }
}
