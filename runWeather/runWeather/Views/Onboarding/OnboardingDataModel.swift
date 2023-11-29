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
		title: "Filter the weather by temperature and precipitation preferences",
		description: "Simlpy tap the 'Sparles' icon",
		gradientColors: [Color("OnboardingBlueLightShade"), Color("OnboardingBlue")]
	)
]
