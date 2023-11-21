//
//  PrecipitationSelectView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/21/23.
//

import SwiftUI

struct PrecipitationSelectView: View {
	@State private var selectedPrecipitation = "< 20%"
	let precipitationLevels = ["0 %", "< 20%", "< 40%", "< 60%", "< 80%"]

	var body: some View {
		HStack {
			Text("Precipitation Level")
				.font(.headline)
				.padding()

			Picker("Precipitation Level", selection: $selectedPrecipitation) {
				ForEach(precipitationLevels, id: \.self) { level in
					Text(level).tag(level)
				}
			}
			.pickerStyle(MenuPickerStyle())
			.frame(maxWidth: .infinity, alignment: .center)
		}
		.padding()
	}
}
