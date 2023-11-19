//
//  ZipeCodeInputView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/18/23.
//
import SwiftUI

struct ZipCodeView: View {
	@Binding var inputZipCode: String
	var onSubmit: () async -> Void

	var body: some View {
		HStack {
			Spacer()
			TextField("Zip Code", text: $inputZipCode)
				.padding()
				.background(Color.white)
				.cornerRadius(10)
				.foregroundColor(.black)
				.onSubmit {
					Task {
						await onSubmit()
					}
				}
			Spacer()
		}
		.frame(height: 50)
	}
}
