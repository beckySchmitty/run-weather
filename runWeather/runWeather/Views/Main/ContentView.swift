//
//  ContentView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
import SwiftUI

struct ContentView: View {
	@StateObject var userStore = UserStore()
	@StateObject var locationStore = LocationStore()
	@StateObject var hourlyWeatherStore = HourlyWeatherStore()
	@Environment(\.colorScheme)
	var colorScheme: ColorScheme

	var body: some View {
		ZStack {
			TabView {
				HourlyWeatherView(userStore: userStore)
					.tabItem {
						Label("Hourly", systemImage: "clock")
					}
				ProfileView(userStore: userStore)
					.tabItem {
						Label("Profile", systemImage: "person.fill")
					}
			}
			.accentColor(colorScheme == .dark ? .white : Color("tabBlue"))
		}
		.environmentObject(locationStore)
		.environmentObject(hourlyWeatherStore)
	}
}
