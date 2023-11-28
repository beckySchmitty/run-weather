//
//  runWeatherApp.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

@main
struct RunWeatherApp: App {
		@AppStorage("isOnboarding") var isOnboarding = true

		var body: some Scene {
				WindowGroup {
						if isOnboarding {
								OnboardingView()
						} else {
								ContentView()
						}
				}
		}
}
