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
				.overlay(
					RoundedRectangle(cornerRadius: 10)
						.stroke(Color("backgroundBlue"), lineWidth: 2)
				)
				.shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
				.keyboardType(.numberPad)
				.foregroundColor(.black)
				.multilineTextAlignment(.center)
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
