//
//  ContentView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
import SwiftUI

struct ContentView: View {
	@StateObject var user = User()
	@StateObject var locationStore = LocationStore()
	@StateObject var hourlyWeatherStore = HourlyWeatherStore()
	@StateObject var appSettings = AppSettings()

	var body: some View {
		ZStack {
			TabView {
				HourlyWeatherView(user: user)
					.tabItem {
						Label("Hourly", systemImage: "clock")
					}
				ProfileView(user: user)
					.tabItem {
						Label("Profile", systemImage: "person.fill")
					}
			}
		}
		.environmentObject(locationStore)
		.environmentObject(hourlyWeatherStore)
		.environmentObject(appSettings)
	}
}
