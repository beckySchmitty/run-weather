//
//  OnboardingDataModel.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/27/23.
//

import SwiftUI

struct OnboardingDataModel: Equatable {
	var image: String
	var title: String
	var description: String
	var gradientColors: [Color]
}

let onboardingScreens: [OnboardingDataModel] = [
	OnboardingDataModel(
		image: "onboarding1",
		title: "Welcome to Run Weather!",
		description: "Plan your run around the most ideal weather.",
		gradientColors: [Color("OnboardingBlueLightShade"), Color("OnboardingBlue")]
	),
	OnboardingDataModel(
		image: "onboarding2",
		title: "Enter your location",
		description: "And we'll do the rest!",
		gradientColors: [Color("OnboardingBlueLightShade"), Color("OnboardingBlue")]
	),
	OnboardingDataModel(
		image: "onboarding3",
		title: "Filter out the cold and rain",
		description: "Tap the 'Sparkles' icon to filter by your preferences",
		gradientColors: [Color("OnboardingBlueLightShade"), Color("OnboardingBlue")]
	)
]
