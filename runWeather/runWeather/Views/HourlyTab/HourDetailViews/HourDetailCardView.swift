//
//  HourDetailCardView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/16/23.
//

import SwiftUI

struct HourDetailCardView: View {
	var title: String
	var value: String
	var body: some View {
		VStack(alignment: .leading, spacing: 4) {
			Text(title)
				.font(.headline)
				.foregroundColor(.white)
			Text(value)
				.font(.title2)
				.foregroundColor(.white)
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
	}
}
