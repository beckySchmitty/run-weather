//
//  TemperatureSelectView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/21/23.
//

import SwiftUI

struct TemperatureSelectView: View {
	@Binding var selectedTemperature: String
	let temperatures = Array(stride(from: 10, through: 100, by: 1)).map { "\($0)°F" }

	var body: some View {
		HStack {
			Text("Temperature")
				.font(.headline)
//				.padding()
			Picker("Select Temperature", selection: $selectedTemperature) {
				ForEach(temperatures, id: \.self) { temperature in
					Text(temperature).tag(temperature)
				}
			}
			.pickerStyle(MenuPickerStyle())
			.frame(maxWidth: .infinity, alignment: .center)
		}
//		.padding()
	}
}
