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
			TextField("Zip Code", text: $inputZipCode)
				.bold()
				.padding()
				.background(Color("backgroundBlueOpposite"))
				.cornerRadius(10)
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
