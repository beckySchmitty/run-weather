//
//  ErrorSheetView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/27/23.
//
import SwiftUI

struct ErrorSheetView: View {
	let errorMessage: String
	@Binding var isPresented: Bool

	var body: some View {
		VStack(spacing: 20) {
			Text("Oops!")
				.font(.largeTitle)
				.fontWeight(.bold)

			Text(errorMessage)
				.multilineTextAlignment(.center)
				.font(.callout)
				.padding(.horizontal)

			Button(action: {
				isPresented = false
			}) {
				Text("Dismiss")
					.bold()
					.foregroundColor(.white)
					.padding()
					.frame(maxWidth: .infinity)
					.background(Color.blue)
					.cornerRadius(12)
					.padding(.horizontal)
			}
		}
		.padding(.vertical)
		.frame(maxWidth: .infinity)
		.background(Color(.gray))
		.cornerRadius(30)
		.shadow(radius: 5)
		.padding(.horizontal)
	}
}
