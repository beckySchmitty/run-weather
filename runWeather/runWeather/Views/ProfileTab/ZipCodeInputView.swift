//
//  ZipeCodeInputView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/18/23.

import SwiftUI

struct ZipCodeView: View {
	@Binding var inputZipCode: String
	var onSubmit: () async throws -> Void

	var body: some View {
		VStack {
			Text("Enter ZIP Code (US only)")
				.font(.subheadline)
			TextField("", text: $inputZipCode)
				.bold()
				.padding()
				.background(Color("backgroundBlueOpposite"))
				.cornerRadius(Constants.General.cornerRadiusClassic)
				.foregroundColor(Color("backgroundBlue"))
				.accentColor(Color("backgroundBlue"))
				.onSubmit {
					Task {
						try await onSubmit()
					}
				}
		}
		.frame(height: 50)
		.padding()
	}
}
