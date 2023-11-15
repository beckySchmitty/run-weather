//
//  ContentView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
import SwiftUI

struct ContentView: View {
	@StateObject var user = User()
	@StateObject var locationStore = LocationStore()

	var body: some View {
		ZStack {
			TabView {
				Group {
					HourlyWeatherView(user: user)
				}
				.tabItem {
					Label("Hourly", systemImage: "clock")
				}
				Group {
					ProfileView(user: user)
				}
				.tabItem {
					Label("Profile", systemImage: "person.fill")
				}
			}
		}
		.environmentObject(locationStore)
	}
}
