//
//  NoWeatherDataView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct NoWeatherDataView: View {
	@ObservedObject var hourlyWeatherStore: HourlyWeatherStore
	@ObservedObject var user: User
	
	var body: some View {
		VStack {
			Image(systemName: "cloud.sun.fill")
				.resizable()
				.scaledToFit()
				.frame(width: 100, height: 100)
			Text("Update your profile to see the weather forecast")
				.font(.title)
			Button("Load Test Data") {
				hourlyWeatherStore.loadTestData()
				user.locationKey = "not empty"
			}
			.padding()
			.background(Color.blue)
			.foregroundColor(.white)
			.cornerRadius(10)
		}
	}
}
