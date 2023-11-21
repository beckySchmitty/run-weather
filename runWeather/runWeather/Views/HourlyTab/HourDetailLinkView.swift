//
//  HourDetailLinkView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/19/23.
//

import SwiftUI

struct HourDetailLinkView: View {
	var title: String
	var linkDestination: String

	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			if let url = URL(string: linkDestination) {
				Link(title, destination: url)
					.font(.title2)
					.foregroundColor(.white)
			} else {
				// Fallback to default URL
				//				swiftlint:disable:next force_unwrapping
				Link(title, destination: URL(string: "https://www.accuweather.com/")!)
					.font(.title2)
					.foregroundColor(.white)
			}
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
	}
}
